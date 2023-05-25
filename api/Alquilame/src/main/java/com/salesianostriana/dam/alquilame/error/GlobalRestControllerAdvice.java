package com.salesianostriana.dam.alquilame.error;

import com.salesianostriana.dam.alquilame.error.model.impl.ApiErrorImpl;
import com.salesianostriana.dam.alquilame.error.model.impl.ApiValidationSubError;
import com.salesianostriana.dam.alquilame.exception.*;
import com.salesianostriana.dam.alquilame.exception.creditcard.CreditCardNotFoundException;
import com.salesianostriana.dam.alquilame.exception.dwelling.DwellingAccessDeniedException;
import com.salesianostriana.dam.alquilame.exception.dwelling.DwellingBadRequestDeleteException;
import com.salesianostriana.dam.alquilame.exception.dwelling.DwellingBadRequestFavouriteException;
import com.salesianostriana.dam.alquilame.exception.dwelling.DwellingNotFoundException;
import com.salesianostriana.dam.alquilame.exception.favourite.FavouriteAlreadyInListException;
import com.salesianostriana.dam.alquilame.exception.favourite.FavouriteDeleteBadRequestException;
import com.salesianostriana.dam.alquilame.exception.favourite.FavouriteNotFoundException;
import com.salesianostriana.dam.alquilame.exception.favourite.FavouriteOwnDwellingsException;
import com.salesianostriana.dam.alquilame.exception.jwt.JwtTokenException;
import com.salesianostriana.dam.alquilame.exception.province.ProvinceBadRequestDeleteException;
import com.salesianostriana.dam.alquilame.exception.province.ProvinceNotFoundException;
import com.salesianostriana.dam.alquilame.exception.rating.AlreadyRatedException;
import com.salesianostriana.dam.alquilame.exception.rating.RatingNotFoundException;
import com.salesianostriana.dam.alquilame.exception.rating.RatingOwnDwellingException;
import com.salesianostriana.dam.alquilame.exception.rental.PaymentException;
import com.salesianostriana.dam.alquilame.exception.rental.RentalOwnDwellingException;
import com.salesianostriana.dam.alquilame.exception.storage.FileEmptyException;
import com.salesianostriana.dam.alquilame.exception.storage.StorageException;
import com.salesianostriana.dam.alquilame.exception.user.AdminsNotFoundException;
import com.salesianostriana.dam.alquilame.exception.user.PasswordNotMatchException;
import com.salesianostriana.dam.alquilame.exception.user.UserDwellingsNotFoundException;
import com.salesianostriana.dam.alquilame.exception.user.UserNotFoundException;
import org.hibernate.validator.internal.engine.path.PathImpl;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.context.request.ServletWebRequest;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.multipart.MultipartException;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;

import javax.validation.ConstraintViolationException;
import java.util.List;
import java.util.stream.Collectors;

@RestControllerAdvice
public class GlobalRestControllerAdvice extends ResponseEntityExceptionHandler {

    @Override
    protected ResponseEntity<Object> handleExceptionInternal(Exception ex, Object body, HttpHeaders headers, HttpStatus status, WebRequest request) {
        return buildApiError(ex.getMessage(), request, status);
    }

    @Override
    protected ResponseEntity<Object> handleMethodArgumentNotValid(MethodArgumentNotValidException ex, HttpHeaders headers, HttpStatus status, WebRequest request) {
        return buildApiErrorWithSubErrors("Validation error. Please check the sublist.", request, status, ex.getAllErrors());
    }

    @ExceptionHandler({ AuthenticationException.class })
    public ResponseEntity<?> handleAuthenticationException(AuthenticationException ex, WebRequest request) {
        return buildApiError(ex.getMessage(), request, HttpStatus.UNAUTHORIZED);

    }

    @ExceptionHandler({ AccessDeniedException.class })
    public ResponseEntity<?> handleAccessDeniedException(AccessDeniedException ex, WebRequest request) {
        return buildApiError(ex.getMessage(), request, HttpStatus.FORBIDDEN);
    }


    @ExceptionHandler({JwtTokenException.class})
    public ResponseEntity<?> handleTokenException(JwtTokenException ex, WebRequest request) {
        return buildApiError(ex.getMessage(), request, HttpStatus.FORBIDDEN);
    }

    @ExceptionHandler({UsernameNotFoundException.class})
    public ResponseEntity<?> handleUserNotExistsException(UsernameNotFoundException ex, WebRequest request) {
        return buildApiError(ex.getMessage(), request, HttpStatus.UNAUTHORIZED);
    }

    @ExceptionHandler({EmptyListNotFoundException.class})
    public ResponseEntity<?> handleEmptyListNotFoundException(EmptyListNotFoundException ex, WebRequest request) {
        return buildApiError(ex.getMessage(), request, HttpStatus.NOT_FOUND);
    }

    @ExceptionHandler({UserNotFoundException.class})
    public ResponseEntity<?> handleUserNotFoundException(UserNotFoundException ex, WebRequest request) {
        return buildApiError(ex.getMessage(), request, HttpStatus.NOT_FOUND);
    }

    @ExceptionHandler({UserDwellingsNotFoundException.class})
    public ResponseEntity<?> handleUserDwellingsNotFoundException(UserDwellingsNotFoundException ex, WebRequest request) {
        return buildApiError(ex.getMessage(), request, HttpStatus.NOT_FOUND);
    }

    @ExceptionHandler({ProvinceNotFoundException.class})
    public ResponseEntity<?> handleCityNotFoundException(ProvinceNotFoundException ex, WebRequest request) {
        return buildApiError(ex.getMessage(), request, HttpStatus.NOT_FOUND);
    }

    @ExceptionHandler(DwellingBadRequestDeleteException.class)
    public ResponseEntity<?> handleDwellingBadRequestDeleteException(DwellingBadRequestDeleteException ex, WebRequest request) {
        return buildApiError(ex.getMessage(), request, HttpStatus.BAD_REQUEST);
    }

    @ExceptionHandler({DwellingAccessDeniedException.class})
    public ResponseEntity<?> handleDwellingAccessDeniedException(DwellingAccessDeniedException ex, WebRequest request) {
        return buildApiError(ex.getMessage(), request, HttpStatus.BAD_REQUEST);
    }

    @ExceptionHandler(FavouriteAlreadyInListException.class)
    public ResponseEntity<?> handleFavouriteAlreadyInListException(FavouriteAlreadyInListException ex, WebRequest request) {
        return buildApiError(ex.getMessage(), request, HttpStatus.BAD_REQUEST);
    }

    @ExceptionHandler(ProvinceBadRequestDeleteException.class)
    public ResponseEntity<?> handleProvinceBadRequestDeleteException(ProvinceBadRequestDeleteException ex, WebRequest request) {
        return buildApiError(ex.getMessage(), request, HttpStatus.BAD_REQUEST);
    }

    @ExceptionHandler(FavouriteNotFoundException.class)
    public ResponseEntity<?> handleFavouriteNotFoundException(FavouriteNotFoundException ex, WebRequest request) {
        return buildApiError(ex.getMessage(), request, HttpStatus.NOT_FOUND);
    }

    @ExceptionHandler(FavouriteDeleteBadRequestException.class)
    public ResponseEntity<?> handleFavouriteDeleteBadRequestException(FavouriteDeleteBadRequestException ex, WebRequest request) {
        return buildApiError(ex.getMessage(), request, HttpStatus.BAD_REQUEST);
    }

    @ExceptionHandler(DwellingNotFoundException.class)
    public ResponseEntity<?> handleDwellingNotFoundException(DwellingNotFoundException ex, WebRequest request) {
        return buildApiError(ex.getMessage(), request, HttpStatus.NOT_FOUND);
    }

    @ExceptionHandler(DwellingBadRequestFavouriteException.class)
    public ResponseEntity<?> handleDwellingBadRequestFavouriteException(DwellingBadRequestFavouriteException ex, WebRequest request) {
        return buildApiError(ex.getMessage(), request, HttpStatus.BAD_REQUEST);
    }

    @ExceptionHandler(FavouriteOwnDwellingsException.class)
    public ResponseEntity<?> handleFavouriteOwnDwellingsException(FavouriteOwnDwellingsException ex, WebRequest request) {
        return buildApiError(ex.getMessage(), request, HttpStatus.BAD_REQUEST);
    }

    @ExceptionHandler(StorageException.class)
    public ResponseEntity<?> handleStorageException(StorageException ex, WebRequest request) {
        return buildApiError(ex.getMessage(), request, HttpStatus.BAD_REQUEST);
    }

    @ExceptionHandler(FileEmptyException.class)
    public ResponseEntity<?> handleFileEmptyException(FileEmptyException ex, WebRequest request) {
        return buildApiError(ex.getMessage(), request, HttpStatus.BAD_REQUEST);
    }

    @ExceptionHandler(PasswordNotMatchException.class)
    public ResponseEntity<?> handlePasswordNotMatchException(PasswordNotMatchException ex, WebRequest request) {
        return buildApiError(ex.getMessage(), request, HttpStatus.BAD_REQUEST);
    }

    @ExceptionHandler(MultipartException.class)
    public ResponseEntity<?> handleMultipartException(MultipartException ex, WebRequest request) {
        return buildApiError(ex.getMessage(), request, HttpStatus.BAD_REQUEST);
    }

    @ExceptionHandler(RatingNotFoundException.class)
    public ResponseEntity<?> handleRatingNotFoundException(RatingNotFoundException ex, WebRequest request) {
        return buildApiError(ex.getMessage(), request, HttpStatus.NOT_FOUND);
    }

    @ExceptionHandler(AlreadyRatedException.class)
    public ResponseEntity<?> handleAlreadyRatedException(AlreadyRatedException ex, WebRequest request) {
        return buildApiError(ex.getMessage(), request, HttpStatus.BAD_REQUEST);
    }

    @ExceptionHandler(RatingOwnDwellingException.class)
    public ResponseEntity<?> handleRatingOwnDwellingException(RatingOwnDwellingException ex, WebRequest request) {
        return buildApiError(ex.getMessage(), request, HttpStatus.BAD_REQUEST);
    }

    @ExceptionHandler(AdminsNotFoundException.class)
    public ResponseEntity<?> handleAdminsNotFoundException(AdminsNotFoundException ex, WebRequest request) {
        return buildApiError(ex.getMessage(), request, HttpStatus.NOT_FOUND);
    }

    @ExceptionHandler(PaymentException.class)
    public ResponseEntity<?> handlePaymentException(PaymentException ex, WebRequest request) {
        return buildApiError(ex.getMessage(), request, HttpStatus.BAD_REQUEST);
    }

    @ExceptionHandler(RentalOwnDwellingException.class)
    public ResponseEntity<?> handleRentalOwnDwellingException(RentalOwnDwellingException ex, WebRequest request) {
        return buildApiError(ex.getMessage(), request, HttpStatus.BAD_REQUEST);
    }

    @ExceptionHandler(CreditCardNotFoundException.class)
    public ResponseEntity<?> handleCreditCardNotFoundException(CreditCardNotFoundException ex, WebRequest request) {
        return buildApiError(ex.getMessage(), request, HttpStatus.NOT_FOUND);
    }

    @ExceptionHandler({ConstraintViolationException.class})
    public ResponseEntity<?> handleConstraintViolationException(ConstraintViolationException exception, WebRequest request) {
        return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                .body(
                        ApiErrorImpl.builder()
                                .status(HttpStatus.BAD_REQUEST)
                                .message("Constraint Validation error. Please check the sublist")
                                .path(((ServletWebRequest) request).getRequest().getRequestURI())
                                .subErrors(exception.getConstraintViolations()
                                        .stream()
                                        .map(constraintViolation -> {
                                            return ApiValidationSubError.builder()
                                                    .message(constraintViolation.getMessage())
                                                    .rejectedValue(constraintViolation.getInvalidValue())
                                                    .object(constraintViolation.getRootBean().getClass().getSimpleName())
                                                    .field(((PathImpl) constraintViolation.getPropertyPath()).getLeafNode().asString())
                                                    .build();
                                        })
                                        .collect(Collectors.toList())
                                )
                                .build()
                );
    }

    private final ResponseEntity<Object> buildApiError(String message, WebRequest request, HttpStatus status) {
        return ResponseEntity
                .status(status)
                .body(
                        ApiErrorImpl.builder()
                                .status(status)
                                .message(message)
                                .path(((ServletWebRequest) request).getRequest().getRequestURI())
                                .build()
                );
    }

    private final ResponseEntity<Object> buildApiErrorWithSubErrors(String message, WebRequest request, HttpStatus status, List<ObjectError> subErrors) {
        return ResponseEntity
                .status(status)
                .body(
                        ApiErrorImpl.builder()
                                .status(status)
                                .message(message)
                                .path(((ServletWebRequest) request).getRequest().getRequestURI())
                                .subErrors(subErrors.stream()
                                        .map(ApiValidationSubError::fromObjectError)
                                        .collect(Collectors.toList())
                                )
                                .build()
                );

    }

}
