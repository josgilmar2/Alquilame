package com.salesianostriana.dam.alquilame.user.service;

import com.salesianostriana.dam.alquilame.dwelling.dto.AllDwellingResponse;
import com.salesianostriana.dam.alquilame.dwelling.model.Dwelling;
import com.salesianostriana.dam.alquilame.dwelling.repo.DwellingRepository;
import com.salesianostriana.dam.alquilame.exception.EmptyListNotFoundException;
import com.salesianostriana.dam.alquilame.exception.favourite.FavouriteNotFoundException;
import com.salesianostriana.dam.alquilame.exception.rental.PaymentException;
import com.salesianostriana.dam.alquilame.exception.user.AdminsNotFoundException;
import com.salesianostriana.dam.alquilame.exception.user.PasswordNotMatchException;
import com.salesianostriana.dam.alquilame.exception.user.UserNotFoundException;
import com.salesianostriana.dam.alquilame.files.service.StorageService;
import com.salesianostriana.dam.alquilame.rating.model.Rating;
import com.salesianostriana.dam.alquilame.rating.repository.RatingRepository;
import com.salesianostriana.dam.alquilame.search.spec.GenericSpecificationBuilder;
import com.salesianostriana.dam.alquilame.search.util.SearchCriteria;
import com.salesianostriana.dam.alquilame.search.util.SearchCriteriaExtractor;
import com.salesianostriana.dam.alquilame.user.dto.*;
import com.salesianostriana.dam.alquilame.user.model.User;
import com.salesianostriana.dam.alquilame.user.model.UserRole;
import com.salesianostriana.dam.alquilame.user.repo.UserRepository;
import com.stripe.Stripe;
import com.stripe.exception.StripeException;
import com.stripe.model.Customer;
import com.stripe.param.CustomerCreateParams;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.web.multipart.MultipartFile;

import javax.persistence.EntityGraph;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;
import java.time.LocalDateTime;
import java.util.EnumSet;
import java.util.List;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class UserService {

    private final PasswordEncoder passwordEncoder;
    private final UserRepository userRepository;
    private final StorageService storageService;

    @Value("${stripe.key.secret}")
    private String secretKey;

    private Customer stripeCustomer(CreateUserDto dto) {
        try {

            Stripe.apiKey = secretKey;

            CustomerCreateParams.Builder params = new CustomerCreateParams.Builder()
                    .setEmail(dto.getEmail())
                    .setPhone(dto.getPhoneNumber())
                    .setName(dto.getFullName());

            return Customer.create(params.build());

        } catch (StripeException ex) {
            throw new PaymentException("An error occurred while creating the customer");
        }
    }

    public User createUser(CreateUserDto dto, EnumSet<UserRole> roles) {

        Customer customer = stripeCustomer(dto);

        User result = User.builder()
                .username(dto.getUsername())
                .fullName(dto.getFullName())
                .email(dto.getEmail())
                .address(dto.getAddress())
                .phoneNumber(dto.getPhoneNumber())
                .password(passwordEncoder.encode(dto.getPassword()))
                .roles(roles)
                .stripeCustomerId(customer.getId())
                .build();

        return userRepository.save(result);
    }

    public User createUserWithInquilinoRole(CreateUserDto dto) {
        return createUser(dto, EnumSet.of(UserRole.INQUILINO));
    }

    public User createUSerWitPropietarioRole(CreateUserDto dto) {
        return createUser(dto, EnumSet.of(UserRole.PROPIETARIO));
    }

    public User createUserWithAdminRole(CreateUserDto dto) {
        return createUser(dto, EnumSet.of(UserRole.ADMIN));
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

    public List<User> findRatedUserDwellings(Long id) {
        return userRepository.findRatedUserDwellings(id);
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

    @Transactional
    public Optional<User> findUserRatedDwellings(UUID id) {
        return userRepository.findUserRatedDwellings(id);
    }

    @Transactional
    public void delete(User user) {
        User toDelete = userRepository.findById(user.getId())
                .orElseThrow(() -> new UserNotFoundException(user.getId()));

        userRepository.deleteRatings(toDelete.getId());

        toDelete.getFavourites().forEach(dwelling -> dwelling.removeUser(toDelete));
        userRepository.delete(toDelete);

    }

    @Transactional
    public void deleteUserByAdmin(UUID id) {
        User toDelete = userRepository.findById(id)
                .orElseThrow(() -> new UserNotFoundException(id));

        userRepository.deleteRatings(toDelete.getId());

        toDelete.getFavourites().forEach(dwelling -> dwelling.removeUser(toDelete));
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

    public User banUser(UUID id) {
        User toBan = userRepository.findById(id)
                .orElseThrow(() -> new UserNotFoundException(id));

        toBan.setEnabled(false);
        return userRepository.save(toBan);
    }

    public User unbanUser(UUID id) {
        User toUnban = userRepository.findById(id)
                .orElseThrow(() -> new UserNotFoundException(id));

        toUnban.setEnabled(true);
        return userRepository.save(toUnban);
    }

    public User findOneUser(UUID id) {
        return userRepository.findById(id)
                .orElseThrow(() -> new UserNotFoundException(id));
    }

    public User editUserByAdmin(EditUserProfileDto dto, UUID id) {
        return userRepository.findById(id)
                .map(toEdit -> {
                    toEdit.setFullName(dto.getFullName());
                    toEdit.setAddress(dto.getAddress());
                    toEdit.setPhoneNumber(dto.getPhoneNumber());
                    return userRepository.save(toEdit);
                }).orElseThrow(() -> new UserNotFoundException(id));
    }

    public User editAvatarByAdmin(MultipartFile file, UUID id) {
        String filename = storageService.store(file);

        return userRepository.findById(id)
                .map(toEdit -> {
                    toEdit.setAvatar(filename);
                    return userRepository.save(toEdit);
                }).orElseThrow(() -> new UserNotFoundException(id));
    }

    public int usersNumbers() {
        List<User> result = userRepository.findAll();
        if (result.isEmpty())
            throw new EmptyListNotFoundException(User.class);
        return result.size();
    }
}
