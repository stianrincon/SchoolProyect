SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `school_data_base` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `school_data_base` ;

-- -----------------------------------------------------
-- Table `school_data_base`.`SCHOOL`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `school_data_base`.`SCHOOL` (
  `school_id` INT NOT NULL AUTO_INCREMENT ,
  `school_name` VARCHAR(100) NOT NULL ,
  `school_address` VARCHAR(50) NOT NULL ,
  `school_phone` VARCHAR(10) NOT NULL ,
  PRIMARY KEY (`school_id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `school_data_base`.`GRADE`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `school_data_base`.`GRADE` (
  `grade_id` INT NOT NULL AUTO_INCREMENT ,
  `grade_name` VARCHAR(20) NOT NULL ,
  `grade_year` YEAR NOT NULL ,
  `grade_school_id` INT NOT NULL ,
  PRIMARY KEY (`grade_id`) ,
  INDEX `fk_GRADE_SCHOOL_idx` (`grade_school_id` ASC) ,
  CONSTRAINT `fk_GRADE_SCHOOL`
    FOREIGN KEY (`grade_school_id` )
    REFERENCES `school_data_base`.`SCHOOL` (`school_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `school_data_base`.`TEACHER`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `school_data_base`.`TEACHER` (
  `teacher_id` INT NOT NULL AUTO_INCREMENT ,
  `t_document_id` VARCHAR(12) NOT NULL ,
  `t_first_name` VARCHAR(50) NOT NULL ,
  `t_last_name` VARCHAR(50) NOT NULL ,
  `t_mobile_number` VARCHAR(10) NOT NULL ,
  `t_address` VARCHAR(50) NOT NULL ,
  `t_email` VARCHAR(50) NOT NULL ,
  `t_hire_date` DATE NOT NULL ,
  PRIMARY KEY (`teacher_id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `school_data_base`.`COURSE`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `school_data_base`.`COURSE` (
  `course_id` INT NOT NULL AUTO_INCREMENT ,
  `course_name` VARCHAR(20) NOT NULL ,
  `course_grade_id` INT NOT NULL ,
  `course_teacher_id` INT NOT NULL ,
  PRIMARY KEY (`course_id`) ,
  INDEX `fk_COURSE_GRADE1_idx` (`course_grade_id` ASC) ,
  INDEX `fk_COURSE_TEACHER1_idx` (`course_teacher_id` ASC) ,
  CONSTRAINT `fk_COURSE_GRADE1`
    FOREIGN KEY (`course_grade_id` )
    REFERENCES `school_data_base`.`GRADE` (`grade_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_COURSE_TEACHER1`
    FOREIGN KEY (`course_teacher_id` )
    REFERENCES `school_data_base`.`TEACHER` (`teacher_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `school_data_base`.`STUDENT`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `school_data_base`.`STUDENT` (
  `student_id` INT NOT NULL AUTO_INCREMENT ,
  `s_document_id` VARCHAR(12) NOT NULL ,
  `s_first_name` VARCHAR(50) NOT NULL ,
  `s_last_name` VARCHAR(50) NOT NULL ,
  `s_mobile_number` VARCHAR(10) NOT NULL ,
  `s_address` VARCHAR(50) NOT NULL ,
  `s_gender` CHAR NOT NULL ,
  `s_date_of_birth` DATE NOT NULL ,
  PRIMARY KEY (`student_id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `school_data_base`.`COURSE_HISTORY`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `school_data_base`.`COURSE_HISTORY` (
  `course_history_id` VARCHAR(45) NOT NULL ,
  `course_history_course_id` INT NOT NULL ,
  `course_history_student_id` INT NOT NULL ,
  INDEX `fk_COURSE_HISTORY_COURSE1_idx` (`course_history_course_id` ASC) ,
  INDEX `fk_COURSE_HISTORY_STUDENT1_idx` (`course_history_student_id` ASC) ,
  PRIMARY KEY (`course_history_id`) ,
  CONSTRAINT `fk_COURSE_HISTORY_COURSE1`
    FOREIGN KEY (`course_history_course_id` )
    REFERENCES `school_data_base`.`COURSE` (`course_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_COURSE_HISTORY_STUDENT1`
    FOREIGN KEY (`course_history_student_id` )
    REFERENCES `school_data_base`.`STUDENT` (`student_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `school_data_base`.`PERIOD`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `school_data_base`.`PERIOD` (
  `period_id` INT NOT NULL AUTO_INCREMENT ,
  `period_name` VARCHAR(10) NOT NULL ,
  `start_date` DATE NULL ,
  `end_date` DATE NULL ,
  PRIMARY KEY (`period_id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `school_data_base`.`SUBJECT`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `school_data_base`.`SUBJECT` (
  `subject_id` INT NOT NULL AUTO_INCREMENT ,
  `subject_name` VARCHAR(20) NOT NULL ,
  `subject_hours` INT NOT NULL ,
  `subject_grade_id` INT NOT NULL ,
  PRIMARY KEY (`subject_id`) ,
  INDEX `fk_SUBJECT_GRADE1_idx` (`subject_grade_id` ASC) ,
  CONSTRAINT `fk_SUBJECT_GRADE1`
    FOREIGN KEY (`subject_grade_id` )
    REFERENCES `school_data_base`.`GRADE` (`grade_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `school_data_base`.`ALLOCATION`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `school_data_base`.`ALLOCATION` (
  `allocation_id` INT NOT NULL ,
  `allocation_subject_id` INT NOT NULL ,
  `allocation_course_id` INT NOT NULL ,
  `allocation_teacher_id` INT NOT NULL ,
  INDEX `fk_ALLOCATION_SUBJECT1_idx` (`allocation_subject_id` ASC) ,
  INDEX `fk_ALLOCATION_COURSE1_idx` (`allocation_course_id` ASC) ,
  INDEX `fk_ALLOCATION_TEACHER1_idx` (`allocation_teacher_id` ASC) ,
  PRIMARY KEY (`allocation_id`) ,
  CONSTRAINT `fk_ALLOCATION_SUBJECT1`
    FOREIGN KEY (`allocation_subject_id` )
    REFERENCES `school_data_base`.`SUBJECT` (`subject_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ALLOCATION_COURSE1`
    FOREIGN KEY (`allocation_course_id` )
    REFERENCES `school_data_base`.`COURSE` (`course_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ALLOCATION_TEACHER1`
    FOREIGN KEY (`allocation_teacher_id` )
    REFERENCES `school_data_base`.`TEACHER` (`teacher_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `school_data_base`.`SCORE`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `school_data_base`.`SCORE` (
  `score_number` INT NOT NULL ,
  `score_text` VARCHAR(15) NOT NULL ,
  `score_student_id` INT NOT NULL ,
  `score_period_id` INT NOT NULL ,
  `score_allocation_id` INT NOT NULL ,
  INDEX `fk_SCORE_STUDENT1_idx` (`score_student_id` ASC) ,
  INDEX `fk_SCORE_PERIOD1_idx` (`score_period_id` ASC) ,
  INDEX `fk_SCORE_ALLOCATION1_idx` (`score_allocation_id` ASC) ,
  CONSTRAINT `fk_SCORE_STUDENT1`
    FOREIGN KEY (`score_student_id` )
    REFERENCES `school_data_base`.`STUDENT` (`student_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_SCORE_PERIOD1`
    FOREIGN KEY (`score_period_id` )
    REFERENCES `school_data_base`.`PERIOD` (`period_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_SCORE_ALLOCATION1`
    FOREIGN KEY (`score_allocation_id` )
    REFERENCES `school_data_base`.`ALLOCATION` (`allocation_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `school_data_base`.`GOAL`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `school_data_base`.`GOAL` (
  `goal_id` INT NOT NULL AUTO_INCREMENT ,
  `goal_description` VARCHAR(1000) NOT NULL ,
  `goal_subject_id` INT NOT NULL ,
  `goal_period_id` INT NOT NULL ,
  PRIMARY KEY (`goal_id`) ,
  INDEX `fk_GOAL_SUBJECT1_idx` (`goal_subject_id` ASC) ,
  INDEX `fk_GOAL_PERIOD1_idx` (`goal_period_id` ASC) ,
  CONSTRAINT `fk_GOAL_SUBJECT1`
    FOREIGN KEY (`goal_subject_id` )
    REFERENCES `school_data_base`.`SUBJECT` (`subject_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_GOAL_PERIOD1`
    FOREIGN KEY (`goal_period_id` )
    REFERENCES `school_data_base`.`PERIOD` (`period_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `school_data_base`.`OBSERVATION`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `school_data_base`.`OBSERVATION` (
  `observation_description` VARCHAR(1000) NOT NULL ,
  `observation_period_id` INT NOT NULL ,
  `observation_course_history_id` VARCHAR(45) NOT NULL ,
  INDEX `fk_OBSERVATION_PERIOD1_idx` (`observation_period_id` ASC) ,
  INDEX `fk_OBSERVATION_COURSE_HISTORY1_idx` (`observation_course_history_id` ASC) ,
  CONSTRAINT `fk_OBSERVATION_PERIOD1`
    FOREIGN KEY (`observation_period_id` )
    REFERENCES `school_data_base`.`PERIOD` (`period_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_OBSERVATION_COURSE_HISTORY1`
    FOREIGN KEY (`observation_course_history_id` )
    REFERENCES `school_data_base`.`COURSE_HISTORY` (`course_history_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `school_data_base` ;

CREATE USER 'admin' IDENTIFIED BY 'hell0w0rd';

GRANT ALL ON `school_data_base`.* TO 'admin';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
