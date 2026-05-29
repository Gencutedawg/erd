-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema pasting_ddb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema pasting_ddb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pasting_ddb` DEFAULT CHARACTER SET utf8mb4 ;
USE `pasting_ddb` ;

-- -----------------------------------------------------
-- Table `pasting_ddb`.`curing_booth`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pasting_ddb`.`curing_booth` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `cb_name` VARCHAR(100) NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  `created_by` INT(11) NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
  `updated_by` INT(11) NULL DEFAULT NULL,
  `is_active` TINYINT(1) NULL DEFAULT 1,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `pasting_ddb`.`user_role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pasting_ddb`.`user_role` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `user_role_name` VARCHAR(100) NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  `created_by` INT(11) NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
  `updated_by` INT(11) NULL DEFAULT NULL,
  `is_active` TINYINT(1) NULL DEFAULT 1,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `pasting_ddb`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pasting_ddb`.`users` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(100) NOT NULL,
  `mid_name` VARCHAR(100) NULL DEFAULT NULL,
  `last_name` VARCHAR(100) NOT NULL,
  `user_role_id` INT(11) NULL DEFAULT NULL,
  `username` VARCHAR(100) NOT NULL,
  `email` VARCHAR(150) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  `created_by` INT(11) NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
  `updated_by` INT(11) NULL DEFAULT NULL,
  `is_active` TINYINT(1) NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username` (`username` ASC) VISIBLE,
  UNIQUE INDEX `email` (`email` ASC) VISIBLE,
  INDEX `fk_users_role` (`user_role_id` ASC) VISIBLE,
  CONSTRAINT `fk_users_role`
    FOREIGN KEY (`user_role_id`)
    REFERENCES `pasting_ddb`.`user_role` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `pasting_ddb`.`operator`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pasting_ddb`.`operator` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `users_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_operator_user` (`users_id` ASC) VISIBLE,
  CONSTRAINT `fk_operator_user`
    FOREIGN KEY (`users_id`)
    REFERENCES `pasting_ddb`.`users` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `pasting_ddb`.`pasting_prod_line`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pasting_ddb`.`pasting_prod_line` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `line_name` VARCHAR(100) NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  `created_by` INT(11) NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
  `updated_by` INT(11) NULL DEFAULT NULL,
  `is_active` TINYINT(1) NULL DEFAULT 1,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `pasting_ddb`.`time_shift`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pasting_ddb`.`time_shift` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `shift_name` VARCHAR(100) NOT NULL,
  `start_time` TIME NOT NULL,
  `end_time` TIME NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  `created_by` INT(11) NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
  `updated_by` INT(11) NULL DEFAULT NULL,
  `is_active` TINYINT(1) NULL DEFAULT 1,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `pasting_ddb`.`plate_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pasting_ddb`.`plate_type` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `plate_name` VARCHAR(100) NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  `created_by` INT(11) NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
  `updated_by` INT(11) NULL DEFAULT NULL,
  `is_active` TINYINT(1) NULL DEFAULT 1,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `pasting_ddb`.`plate_specification`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pasting_ddb`.`plate_specification` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `plate_type_id` INT(11) NOT NULL,
  `weight_usl` DECIMAL(10,2) NULL DEFAULT NULL,
  `weight_target` DECIMAL(10,2) NULL DEFAULT NULL,
  `weight_lsl` DECIMAL(10,2) NULL DEFAULT NULL,
  `thick_usl` DECIMAL(10,2) NULL DEFAULT NULL,
  `thick_target` DECIMAL(10,2) NULL DEFAULT NULL,
  `thick_lsl` DECIMAL(10,2) NULL DEFAULT NULL,
  `mc_lsl` DECIMAL(10,2) NULL DEFAULT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  `created_by` INT(11) NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
  `updated_by` INT(11) NULL DEFAULT NULL,
  `is_active` TINYINT(1) NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  INDEX `fk_specs_plate_type` (`plate_type_id` ASC) VISIBLE,
  CONSTRAINT `fk_specs_plate_type`
    FOREIGN KEY (`plate_type_id`)
    REFERENCES `pasting_ddb`.`plate_type` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `pasting_ddb`.`run_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pasting_ddb`.`run_type` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `run_type_name` VARCHAR(100) NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  `created_by` INT(11) NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
  `updated_by` INT(11) NULL DEFAULT NULL,
  `is_active` TINYINT(1) NULL DEFAULT 1,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `pasting_ddb`.`plate_rack`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pasting_ddb`.`plate_rack` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `plate_rack_no` VARCHAR(100) NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  `created_by` INT(11) NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
  `updated_by` INT(11) NULL DEFAULT NULL,
  `is_active` TINYINT(1) NULL DEFAULT 1,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `pasting_ddb`.`plate_quality_status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pasting_ddb`.`plate_quality_status` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `status_name` VARCHAR(100) NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  `created_by` INT(11) NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
  `updated_by` INT(11) NULL DEFAULT NULL,
  `is_active` TINYINT(1) NULL DEFAULT 1,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `pasting_ddb`.`plate_mc_log`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pasting_ddb`.`plate_mc_log` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `pasting_line_id` INT(11) NOT NULL,
  `operator_id` INT(11) NOT NULL,
  `time_shift_id` INT(11) NOT NULL,
  `plate_type_id` INT(11) NOT NULL,
  `plate_specs_id` INT(11) NOT NULL,
  `run_type_id` INT(11) NOT NULL,
  `plate_rack_id` INT(11) NOT NULL,
  `curing_booth_id` INT(11) NOT NULL,
  `mc_date_log` DATE NULL DEFAULT NULL,
  `mc_time_log` TIME NULL DEFAULT NULL,
  `mc_result` DECIMAL(10,2) NULL DEFAULT NULL,
  `plate_status_id` INT(11) NOT NULL,
  `mc_remarks` VARCHAR(255) NULL DEFAULT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  `created_by` INT(11) NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
  `updated_by` INT(11) NULL DEFAULT NULL,
  `is_active` TINYINT(1) NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  INDEX `pasting_line_id` (`pasting_line_id` ASC) VISIBLE,
  INDEX `operator_id` (`operator_id` ASC) VISIBLE,
  INDEX `time_shift_id` (`time_shift_id` ASC) VISIBLE,
  INDEX `plate_type_id` (`plate_type_id` ASC) VISIBLE,
  INDEX `plate_specs_id` (`plate_specs_id` ASC) VISIBLE,
  INDEX `run_type_id` (`run_type_id` ASC) VISIBLE,
  INDEX `plate_rack_id` (`plate_rack_id` ASC) VISIBLE,
  INDEX `curing_booth_id` (`curing_booth_id` ASC) VISIBLE,
  INDEX `plate_status_id` (`plate_status_id` ASC) VISIBLE,
  CONSTRAINT `plate_mc_log_ibfk_1`
    FOREIGN KEY (`pasting_line_id`)
    REFERENCES `pasting_ddb`.`pasting_prod_line` (`id`),
  CONSTRAINT `plate_mc_log_ibfk_2`
    FOREIGN KEY (`operator_id`)
    REFERENCES `pasting_ddb`.`operator` (`id`),
  CONSTRAINT `plate_mc_log_ibfk_3`
    FOREIGN KEY (`time_shift_id`)
    REFERENCES `pasting_ddb`.`time_shift` (`id`),
  CONSTRAINT `plate_mc_log_ibfk_4`
    FOREIGN KEY (`plate_type_id`)
    REFERENCES `pasting_ddb`.`plate_type` (`id`),
  CONSTRAINT `plate_mc_log_ibfk_5`
    FOREIGN KEY (`plate_specs_id`)
    REFERENCES `pasting_ddb`.`plate_specification` (`id`),
  CONSTRAINT `plate_mc_log_ibfk_6`
    FOREIGN KEY (`run_type_id`)
    REFERENCES `pasting_ddb`.`run_type` (`id`),
  CONSTRAINT `plate_mc_log_ibfk_7`
    FOREIGN KEY (`plate_rack_id`)
    REFERENCES `pasting_ddb`.`plate_rack` (`id`),
  CONSTRAINT `plate_mc_log_ibfk_8`
    FOREIGN KEY (`curing_booth_id`)
    REFERENCES `pasting_ddb`.`curing_booth` (`id`),
  CONSTRAINT `plate_mc_log_ibfk_9`
    FOREIGN KEY (`plate_status_id`)
    REFERENCES `pasting_ddb`.`plate_quality_status` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `pasting_ddb`.`plate_thickness_log`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pasting_ddb`.`plate_thickness_log` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `pasting_line_id` INT(11) NOT NULL,
  `operator_id` INT(11) NOT NULL,
  `time_shift_id` INT(11) NOT NULL,
  `plate_type_id` INT(11) NOT NULL,
  `plate_specs_id` INT(11) NOT NULL,
  `run_type_id` INT(11) NOT NULL,
  `thick_date_log` DATE NULL DEFAULT NULL,
  `thick_time_log` TIME NULL DEFAULT NULL,
  `op_c1` DECIMAL(10,2) NULL DEFAULT NULL,
  `op_c2` DECIMAL(10,2) NULL DEFAULT NULL,
  `op_c3` DECIMAL(10,2) NULL DEFAULT NULL,
  `op_c4` DECIMAL(10,2) NULL DEFAULT NULL,
  `nop_c1` DECIMAL(10,2) NULL DEFAULT NULL,
  `nop_c2` DECIMAL(10,2) NULL DEFAULT NULL,
  `nop_c3` DECIMAL(10,2) NULL DEFAULT NULL,
  `nop_c4` DECIMAL(10,2) NULL DEFAULT NULL,
  `plate_status_id` INT(11) NOT NULL,
  `thickness_remarks` VARCHAR(255) NULL DEFAULT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  `created_by` INT(11) NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
  `updated_by` INT(11) NULL DEFAULT NULL,
  `is_active` TINYINT(1) NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  INDEX `pasting_line_id` (`pasting_line_id` ASC) VISIBLE,
  INDEX `operator_id` (`operator_id` ASC) VISIBLE,
  INDEX `time_shift_id` (`time_shift_id` ASC) VISIBLE,
  INDEX `plate_type_id` (`plate_type_id` ASC) VISIBLE,
  INDEX `plate_specs_id` (`plate_specs_id` ASC) VISIBLE,
  INDEX `run_type_id` (`run_type_id` ASC) VISIBLE,
  INDEX `plate_status_id` (`plate_status_id` ASC) VISIBLE,
  CONSTRAINT `plate_thickness_log_ibfk_1`
    FOREIGN KEY (`pasting_line_id`)
    REFERENCES `pasting_ddb`.`pasting_prod_line` (`id`),
  CONSTRAINT `plate_thickness_log_ibfk_2`
    FOREIGN KEY (`operator_id`)
    REFERENCES `pasting_ddb`.`operator` (`id`),
  CONSTRAINT `plate_thickness_log_ibfk_3`
    FOREIGN KEY (`time_shift_id`)
    REFERENCES `pasting_ddb`.`time_shift` (`id`),
  CONSTRAINT `plate_thickness_log_ibfk_4`
    FOREIGN KEY (`plate_type_id`)
    REFERENCES `pasting_ddb`.`plate_type` (`id`),
  CONSTRAINT `plate_thickness_log_ibfk_5`
    FOREIGN KEY (`plate_specs_id`)
    REFERENCES `pasting_ddb`.`plate_specification` (`id`),
  CONSTRAINT `plate_thickness_log_ibfk_6`
    FOREIGN KEY (`run_type_id`)
    REFERENCES `pasting_ddb`.`run_type` (`id`),
  CONSTRAINT `plate_thickness_log_ibfk_7`
    FOREIGN KEY (`plate_status_id`)
    REFERENCES `pasting_ddb`.`plate_quality_status` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `pasting_ddb`.`plate_weight_log`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pasting_ddb`.`plate_weight_log` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `pasting_line_id` INT(11) NOT NULL,
  `operator_id` INT(11) NOT NULL,
  `time_shift_id` INT(11) NOT NULL,
  `plate_type_id` INT(11) NOT NULL,
  `plate_specs_id` INT(11) NOT NULL,
  `run_type_id` INT(11) NOT NULL,
  `weight_date_log` DATE NULL DEFAULT NULL,
  `weight_time_log` TIME NULL DEFAULT NULL,
  `w1` DECIMAL(10,2) NULL DEFAULT NULL,
  `w2` DECIMAL(10,2) NULL DEFAULT NULL,
  `w3` DECIMAL(10,2) NULL DEFAULT NULL,
  `w4` DECIMAL(10,2) NULL DEFAULT NULL,
  `w5` DECIMAL(10,2) NULL DEFAULT NULL,
  `w6` DECIMAL(10,2) NULL DEFAULT NULL,
  `w7` DECIMAL(10,2) NULL DEFAULT NULL,
  `w8` DECIMAL(10,2) NULL DEFAULT NULL,
  `plate_status_id` INT(11) NOT NULL,
  `weight_remarks` VARCHAR(255) NULL DEFAULT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  `created_by` INT(11) NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
  `updated_by` INT(11) NULL DEFAULT NULL,
  `is_active` TINYINT(1) NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  INDEX `pasting_line_id` (`pasting_line_id` ASC) VISIBLE,
  INDEX `operator_id` (`operator_id` ASC) VISIBLE,
  INDEX `time_shift_id` (`time_shift_id` ASC) VISIBLE,
  INDEX `plate_type_id` (`plate_type_id` ASC) VISIBLE,
  INDEX `plate_specs_id` (`plate_specs_id` ASC) VISIBLE,
  INDEX `run_type_id` (`run_type_id` ASC) VISIBLE,
  INDEX `plate_status_id` (`plate_status_id` ASC) VISIBLE,
  CONSTRAINT `plate_weight_log_ibfk_1`
    FOREIGN KEY (`pasting_line_id`)
    REFERENCES `pasting_ddb`.`pasting_prod_line` (`id`),
  CONSTRAINT `plate_weight_log_ibfk_2`
    FOREIGN KEY (`operator_id`)
    REFERENCES `pasting_ddb`.`operator` (`id`),
  CONSTRAINT `plate_weight_log_ibfk_3`
    FOREIGN KEY (`time_shift_id`)
    REFERENCES `pasting_ddb`.`time_shift` (`id`),
  CONSTRAINT `plate_weight_log_ibfk_4`
    FOREIGN KEY (`plate_type_id`)
    REFERENCES `pasting_ddb`.`plate_type` (`id`),
  CONSTRAINT `plate_weight_log_ibfk_5`
    FOREIGN KEY (`plate_specs_id`)
    REFERENCES `pasting_ddb`.`plate_specification` (`id`),
  CONSTRAINT `plate_weight_log_ibfk_6`
    FOREIGN KEY (`run_type_id`)
    REFERENCES `pasting_ddb`.`run_type` (`id`),
  CONSTRAINT `plate_weight_log_ibfk_7`
    FOREIGN KEY (`plate_status_id`)
    REFERENCES `pasting_ddb`.`plate_quality_status` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
