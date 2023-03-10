-- MySQL Script generated by MySQL Workbench
-- Sun Dec 11 21:26:04 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Usuario` (
  `idUsuario` INT UNSIGNED NOT NULL,
  `usuario` VARCHAR(45) NULL,
  `Contraseña` CHAR(60) NOT NULL,
  PRIMARY KEY (`idUsuario`),
  UNIQUE INDEX `Contraseña_UNIQUE` (`Contraseña` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tipoDNI`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tipoDNI` (
  `idtipoDNI` TINYINT(2) UNSIGNED NOT NULL,
  `tipoDN` VARCHAR(45) NULL,
  PRIMARY KEY (`idtipoDNI`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Genero`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Genero` (
  `idGenero` TINYINT(2) UNSIGNED NOT NULL,
  `Genero` VARCHAR(45) NULL,
  PRIMARY KEY (`idGenero`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Nacionalidad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Nacionalidad` (
  `IdNacionalidad` INT UNSIGNED NOT NULL,
  `Nacionalidad` VARCHAR(45) NULL,
  `Gentilicio` VARCHAR(45) NULL,
  `nroISO` INT NULL,
  PRIMARY KEY (`IdNacionalidad`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pasajeros`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pasajeros` (
  `idPasajero` INT UNSIGNED NOT NULL,
  `Apellido` VARCHAR(45) NULL,
  `Nombre` VARCHAR(45) NULL,
  `tipoDNI_idtipoDNI` INT NOT NULL,
  `Genero_idGenero` INT NOT NULL,
  `Usuario_idUsuario` INT NOT NULL,
  `Nacionalidad_IdNacionalidad` INT NOT NULL,
  PRIMARY KEY (`idPasajero`, `Usuario_idUsuario`),
  INDEX `fk_Pasajeros_tipoDNI_idx` (`tipoDNI_idtipoDNI` ASC) VISIBLE,
  INDEX `fk_Pasajeros_Genero1_idx` (`Genero_idGenero` ASC) VISIBLE,
  INDEX `fk_Pasajeros_Usuario1_idx` (`Usuario_idUsuario` ASC) VISIBLE,
  INDEX `fk_Pasajeros_Nacionalidad1_idx` (`Nacionalidad_IdNacionalidad` ASC) VISIBLE,
  CONSTRAINT `fk_Pasajeros_tipoDNI`
    FOREIGN KEY (`tipoDNI_idtipoDNI`)
    REFERENCES `mydb`.`tipoDNI` (`idtipoDNI`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pasajeros_Genero1`
    FOREIGN KEY (`Genero_idGenero`)
    REFERENCES `mydb`.`Genero` (`idGenero`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pasajeros_Usuario1`
    FOREIGN KEY (`Usuario_idUsuario`)
    REFERENCES `mydb`.`Usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pasajeros_Nacionalidad1`
    FOREIGN KEY (`Nacionalidad_IdNacionalidad`)
    REFERENCES `mydb`.`Nacionalidad` (`IdNacionalidad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Tren`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Tren` (
  `idTren` INT NOT NULL,
  `Locomotora` VARCHAR(45) NULL,
  PRIMARY KEY (`idTren`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Categoria` (
  `idCategoria` INT NOT NULL,
  `Categoria` VARCHAR(45) NULL,
  PRIMARY KEY (`idCategoria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Vagon`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Vagon` (
  `idVagon` INT NOT NULL,
  `Tren_idTren` INT NOT NULL,
  `Categoria_idCategoria` INT NOT NULL,
  PRIMARY KEY (`idVagon`),
  INDEX `fk_Vagon_Tren1_idx` (`Tren_idTren` ASC) VISIBLE,
  INDEX `fk_Vagon_Categoria1_idx` (`Categoria_idCategoria` ASC) VISIBLE,
  CONSTRAINT `fk_Vagon_Tren1`
    FOREIGN KEY (`Tren_idTren`)
    REFERENCES `mydb`.`Tren` (`idTren`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Vagon_Categoria1`
    FOREIGN KEY (`Categoria_idCategoria`)
    REFERENCES `mydb`.`Categoria` (`idCategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`EstadoAsiento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`EstadoAsiento` (
  `idEstadoAsiento` INT NOT NULL,
  `Asiento` VARCHAR(45) NULL,
  PRIMARY KEY (`idEstadoAsiento`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Asiento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Asiento` (
  `idAsiento` INT NOT NULL,
  `Vagon_idVagon` INT NOT NULL,
  `Asiento` INT NULL,
  `EstadoAsiento_idEstadoAsiento` INT NOT NULL,
  PRIMARY KEY (`idAsiento`),
  INDEX `fk_Asiento_Vagon1_idx` (`Vagon_idVagon` ASC) VISIBLE,
  INDEX `fk_Asiento_EstadoAsiento1_idx` (`EstadoAsiento_idEstadoAsiento` ASC) VISIBLE,
  CONSTRAINT `fk_Asiento_Vagon1`
    FOREIGN KEY (`Vagon_idVagon`)
    REFERENCES `mydb`.`Vagon` (`idVagon`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Asiento_EstadoAsiento1`
    FOREIGN KEY (`EstadoAsiento_idEstadoAsiento`)
    REFERENCES `mydb`.`EstadoAsiento` (`idEstadoAsiento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Venta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Venta` (
  `Pasajeros_idPasajero` INT NOT NULL,
  `IdVenta` INT UNSIGNED NOT NULL,
  `fechaVenta` DATETIME NULL,
  INDEX `fk_Venta_Pasajeros1_idx` (`Pasajeros_idPasajero` ASC) VISIBLE,
  PRIMARY KEY (`IdVenta`, `Pasajeros_idPasajero`),
  CONSTRAINT `fk_Venta_Pasajeros1`
    FOREIGN KEY (`Pasajeros_idPasajero`)
    REFERENCES `mydb`.`Pasajeros` (`idPasajero`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Estacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Estacion` (
  `idEstacion` INT NOT NULL,
  `Estacion` VARCHAR(45) NULL,
  PRIMARY KEY (`idEstacion`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Precio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Precio` (
  `idPrecio` INT UNSIGNED NOT NULL,
  `PrecioPasaje` DECIMAL(8,2) NULL,
  `Estacion Origen` INT NOT NULL,
  `Estacion Destino` INT NOT NULL,
  PRIMARY KEY (`idPrecio`, `Estacion Destino`, `Estacion Origen`),
  UNIQUE INDEX `idPrecio_UNIQUE` (`idPrecio` ASC) VISIBLE,
  INDEX `fk_Precio_Estacion1_idx` (`Estacion Origen` ASC) VISIBLE,
  INDEX `fk_Precio_Estacion2_idx` (`Estacion Destino` ASC) VISIBLE,
  CONSTRAINT `fk_Precio_Estacion1`
    FOREIGN KEY (`Estacion Origen`)
    REFERENCES `mydb`.`Estacion` (`idEstacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Precio_Estacion2`
    FOREIGN KEY (`Estacion Destino`)
    REFERENCES `mydb`.`Estacion` (`idEstacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pasajes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pasajes` (
  `nroDePasaje` INT UNSIGNED NOT NULL,
  `Venta_IdVenta` INT NOT NULL,
  `Asiento_idAsiento` INT NOT NULL,
  `Asiento_Vagon_idVagon` INT NOT NULL,
  `Asiento_EstadoAsiento_idEstadoAsiento` INT NOT NULL,
  `Precio_idPrecio` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`nroDePasaje`),
  INDEX `fk_Pasajes_Venta1_idx` (`Venta_IdVenta` ASC) VISIBLE,
  INDEX `fk_Pasajes_Asiento1_idx` (`Asiento_idAsiento` ASC, `Asiento_Vagon_idVagon` ASC, `Asiento_EstadoAsiento_idEstadoAsiento` ASC) VISIBLE,
  UNIQUE INDEX `IdPasaje_UNIQUE` (`nroDePasaje` ASC) VISIBLE,
  INDEX `fk_Pasajes_Precio1_idx` (`Precio_idPrecio` ASC) VISIBLE,
  CONSTRAINT `fk_Pasajes_Venta1`
    FOREIGN KEY (`Venta_IdVenta`)
    REFERENCES `mydb`.`Venta` (`IdVenta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pasajes_Asiento1`
    FOREIGN KEY (`Asiento_idAsiento` , `Asiento_Vagon_idVagon` , `Asiento_EstadoAsiento_idEstadoAsiento`)
    REFERENCES `mydb`.`Asiento` (`idAsiento` , `Vagon_idVagon` , `EstadoAsiento_idEstadoAsiento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pasajes_Precio1`
    FOREIGN KEY (`Precio_idPrecio`)
    REFERENCES `mydb`.`Precio` (`idPrecio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Horario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Horario` (
  `Tren_idTren` INT NOT NULL,
  `Estacion_idEstacion` INT NOT NULL,
  `Hora` TIME NULL,
  PRIMARY KEY (`Tren_idTren`, `Estacion_idEstacion`),
  INDEX `fk_Tren_has_Estacion_Estacion1_idx` (`Estacion_idEstacion` ASC) VISIBLE,
  INDEX `fk_Tren_has_Estacion_Tren1_idx` (`Tren_idTren` ASC) VISIBLE,
  CONSTRAINT `fk_Tren_has_Estacion_Tren1`
    FOREIGN KEY (`Tren_idTren`)
    REFERENCES `mydb`.`Tren` (`idTren`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Tren_has_Estacion_Estacion1`
    FOREIGN KEY (`Estacion_idEstacion`)
    REFERENCES `mydb`.`Estacion` (`idEstacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Ramal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Ramal` (
  `idRamal` INT UNSIGNED NOT NULL,
  `NombreRamal` VARCHAR(45) NULL,
  `Estacion_idEstacion` INT NOT NULL,
  PRIMARY KEY (`idRamal`, `Estacion_idEstacion`),
  UNIQUE INDEX `idRamal_UNIQUE` (`idRamal` ASC) VISIBLE,
  INDEX `fk_Ramal_Estacion1_idx` (`Estacion_idEstacion` ASC) VISIBLE,
  CONSTRAINT `fk_Ramal_Estacion1`
    FOREIGN KEY (`Estacion_idEstacion`)
    REFERENCES `mydb`.`Estacion` (`idEstacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
