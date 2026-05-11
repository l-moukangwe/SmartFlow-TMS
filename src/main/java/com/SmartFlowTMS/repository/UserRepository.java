package com.SmartFlowTMS.repository;

import com.SmartFlowTMS.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, Integer> {
    Optional<User> findByUsernameAndPasswordHash(String username, String passwordHash);
}