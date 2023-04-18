package com.salesianostriana.dam.alquilame.user.service;

import com.salesianostriana.dam.alquilame.dwelling.dto.AllDwellingResponse;
import com.salesianostriana.dam.alquilame.exception.EmptyListNotFoundException;
import com.salesianostriana.dam.alquilame.exception.favourite.FavouriteNotFoundException;
import com.salesianostriana.dam.alquilame.exception.user.PasswordNotMatchException;
import com.salesianostriana.dam.alquilame.exception.user.UserNotFoundException;
import com.salesianostriana.dam.alquilame.files.service.StorageService;
import com.salesianostriana.dam.alquilame.search.spec.GenericSpecificationBuilder;
import com.salesianostriana.dam.alquilame.search.util.SearchCriteria;
import com.salesianostriana.dam.alquilame.search.util.SearchCriteriaExtractor;
import com.salesianostriana.dam.alquilame.user.dto.*;
import com.salesianostriana.dam.alquilame.user.model.User;
import com.salesianostriana.dam.alquilame.user.model.UserRole;
import com.salesianostriana.dam.alquilame.user.repo.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.transaction.Transactional;
import java.time.LocalDateTime;
import java.util.EnumSet;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class UserService {

    private final PasswordEncoder passwordEncoder;
    private final UserRepository userRepository;
    private final StorageService storageService;

    public User createUser(CreateUserDto dto, EnumSet<UserRole> roles) {

        User result = User.builder()
                .username(dto.getUsername())
                .fullName(dto.getFullName())
                .email(dto.getEmail())
                .address(dto.getAddress())
                .phoneNumber(dto.getPhoneNumber())
                .password(passwordEncoder.encode(dto.getPassword()))
                .roles(roles)
                .build();

        return userRepository.save(result);
    }

    public User createUserWithInquilinoRole(CreateUserDto dto) {
        return createUser(dto, EnumSet.of(UserRole.INQUILINO));
    }

    public User createUSerWitPropietarioRole(CreateUserDto dto) {
        return createUser(dto, EnumSet.of(UserRole.PROPIETARIO));
    }

    public Optional<User> findByUsername(String username) {
        return userRepository.findFirstByUsername(username);
    }

    public Optional<User> findById(UUID id) {
        return userRepository.findById(id);
    }

    public Page<UserResponse> search(List<SearchCriteria> params, Pageable pageable) {
        GenericSpecificationBuilder<User> userGenericSpecificationBuilder =
                new GenericSpecificationBuilder<>(params, User.class);
        Specification<User> specification = userGenericSpecificationBuilder.build();
        return userRepository.findAll(specification, pageable).map(UserResponse::fromUser);
    }

    public Page<UserResponse> findAllUsers(String search, Pageable pageable) {
        List<SearchCriteria> params = SearchCriteriaExtractor.extractSearchCriteriaList(search);
        Page<UserResponse> result = search(params, pageable);
        if(result.isEmpty())
            throw new EmptyListNotFoundException(User.class);
        return result;
    }

    public User myProfile(User user) {
        return userRepository.findById(user.getId())
                .orElseThrow(() -> new UserNotFoundException(user.getId()));
    }

    @Transactional
    public Optional<User> findUserWithDwellings(UUID id) {
        return userRepository.findUserWithDwellings(id);
    }

    public List<User> findFavouriteUserDwellings(Long id) {
        return userRepository.findFavouriteUserDwellings(id);
    }

    public boolean existFavourite(UUID id, Long idDwelling) {
        return userRepository.existFavourite(id, idDwelling);
    }

    public User save(User user) {
        return userRepository.save(user);
    }

    public Page<AllDwellingResponse> findFavourites(User user, Pageable pageable) {
        Page<AllDwellingResponse> result = userRepository.findFavourites(user.getId(), pageable);

        if(result.isEmpty())
            throw new FavouriteNotFoundException(user.getUsername());
        return result;
    }

    public User edit(EditUserProfileDto dto, User user) {
        return userRepository.findById(user.getId())
                .map(toEdit -> {
                    toEdit.setFullName(dto.getFullName());
                    toEdit.setAddress(dto.getAddress());
                    toEdit.setPhoneNumber(dto.getPhoneNumber());
                    return userRepository.save(toEdit);
                }).orElseThrow(() -> new UserNotFoundException(user.getId()));
    }

    @Transactional
    public Optional<User> findUserFavouriteDwellings(UUID id) {
        return userRepository.findUserFavouriteDwellings(id);
    }

    public void delete(User user) {
        User toDelete = findUserFavouriteDwellings(user.getId())
                .orElseThrow(() -> new UserNotFoundException(user.getId()));

        toDelete.getFavourites().forEach(dwelling -> {
            dwelling.removeUser(toDelete);
        });

        userRepository.delete(toDelete);

    }

    public User editPassword(EditPasswordDto dto, User user) {
        if(!passwordEncoder.matches(dto.getOldPassword(), user.getPassword()))
            throw new PasswordNotMatchException();
        return userRepository.findById(user.getId())
                .map(user1 -> {
                    user1.setPassword(passwordEncoder.encode(dto.getNewPassword()));
                    user1.setLastPasswordChangeAt(LocalDateTime.now());
                    return save(user1);
                }).orElseThrow(() -> new UserNotFoundException(user.getId()));

    }

    public boolean existsByUsername(String username) {
        return userRepository.existsByUsername(username);
    }

    public boolean existsByEmail(String email) {
        return userRepository.existsByEmail(email);
    }

    public boolean existsByPhoneNumber(String phoneNumber) {
        return userRepository.existsByPhoneNumber(phoneNumber);
    }

    public User editAvatar(MultipartFile file, User user) {
        User user1 = myProfile(user);
        String filename = storageService.store(file);

        user1.setAvatar(filename);
        return userRepository.save(user1);
    }

    public User deleteAvatar(User user) {
        User user1 = myProfile(user);

        user1.setAvatar(null);
        return userRepository.save(user1);
    }
}
