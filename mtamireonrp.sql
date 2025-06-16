-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 16-06-2025 a las 04:28:55
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `mtamireonrp`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cajeros`
--

CREATE TABLE `cajeros` (
  `ID` int(11) NOT NULL,
  `Ubicacion` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cajeros`
--

INSERT INTO `cajeros` (`ID`, `Ubicacion`) VALUES
(1, '[ { \"y\": -1561.6162109375, \"x\": 1254.28125, \"dim\": 0, \"z\": 13.55716133117676, \"int\": 0, \"rotY\": 0, \"rotZ\": 359.8049926757812, \"rotX\": 0 } ]'),
(2, '[ { \"y\": -1582.7802734375, \"x\": 1501.29296875, \"dim\": 0, \"z\": 13.546875, \"int\": 0, \"rotY\": 0, \"rotZ\": 0.59051513671875, \"rotX\": 0 } ]'),
(3, '[ { \"y\": -1359.6640625, \"x\": 2103.78125, \"dim\": 0, \"z\": 23.984375, \"int\": 0, \"rotY\": 0, \"rotZ\": 1.145355224609375, \"rotX\": 0 } ]'),
(4, '[ { \"y\": -1868.7001953125, \"x\": 1809.943359375, \"dim\": 0, \"z\": 13.58316898345947, \"int\": 0, \"rotY\": 0, \"rotZ\": 180.85693359375, \"rotX\": 0 } ]'),
(5, '[ { \"y\": -1769.6865234375, \"x\": 1928.5810546875, \"dim\": 0, \"z\": 13.546875, \"int\": 0, \"rotY\": 0, \"rotZ\": 89.37789916992188, \"rotX\": 0 } ]'),
(6, '[ { \"y\": -925.4072265625, \"x\": 1001.2353515625, \"dim\": 0, \"z\": 42.328125, \"int\": 0, \"rotY\": 0, \"rotZ\": 278.1863098144531, \"rotX\": 0 } ]'),
(7, '[ { \"y\": -1758.015625, \"x\": 2479.537109375, \"dim\": 0, \"z\": 13.546875, \"int\": 0, \"rotY\": 0, \"rotZ\": 181.3843078613281, \"rotX\": 0 } ]'),
(8, '[ { \"y\": -1118.26953125, \"x\": 2115.625, \"dim\": 0, \"z\": 25.29644203186035, \"int\": 0, \"rotY\": 0, \"rotZ\": 163.1412353515625, \"rotX\": 0 } ]'),
(9, '[ { \"y\": -1440.4482421875, \"x\": 710.310546875, \"dim\": 0, \"z\": 13.5390625, \"int\": 0, \"rotY\": 0, \"rotZ\": 177.6983032226562, \"rotX\": 0 } ]'),
(10, '[ { \"y\": -1246.6328125, \"x\": 595.115234375, \"dim\": 0, \"z\": 18.1631908416748, \"int\": 0, \"rotY\": 0, \"rotZ\": 205.4996490478516, \"rotX\": 0 } ]'),
(11, '[ { \"y\": -807.9208984375, \"x\": 1446.9658203125, \"dim\": 0, \"z\": 84.29159545898438, \"int\": 0, \"rotY\": 0, \"rotZ\": 180.2581787109375, \"rotX\": 0 } ]'),
(12, '[ { \"y\": -17.3212890625, \"x\": 2310.3857421875, \"dim\": 0, \"z\": 26.7421875, \"int\": 0, \"rotY\": 0, \"rotZ\": 179.725341796875, \"rotX\": 0 } ]'),
(13, '[ { \"y\": -17.3212890625, \"x\": 2313.57421875, \"dim\": 0, \"z\": 26.7421875, \"int\": 0, \"rotY\": 0, \"rotZ\": 179.725341796875, \"rotX\": 0 } ]'),
(14, '[ { \"y\": -17.3193359375, \"x\": 2316.421875, \"dim\": 0, \"z\": 26.7421875, \"int\": 0, \"rotY\": 0, \"rotZ\": 179.725341796875, \"rotX\": 0 } ]'),
(15, '[ { \"y\": 263.3701171875, \"x\": 1285.27734375, \"dim\": 0, \"z\": 19.5546875, \"int\": 0, \"rotY\": 0, \"rotZ\": 64.52096557617188, \"rotX\": 0 } ]'),
(16, '[ { \"y\": -184.3271484375, \"x\": 192.4521484375, \"dim\": 0, \"z\": 1.578125, \"int\": 0, \"rotY\": 0, \"rotZ\": 266.3868103027344, \"rotX\": 0 } ]'),
(17, '[ { \"y\": -577.9814453125, \"x\": 663.828125, \"dim\": 0, \"z\": 16.3359375, \"int\": 0, \"rotY\": 0, \"rotZ\": 358.1405334472656, \"rotX\": 0 } ]'),
(18, '[ { \"y\": -1171.91796875, \"x\": 1644.8984375, \"dim\": 0, \"z\": 24.078125, \"int\": 0, \"rotY\": 0, \"rotZ\": 182.1313781738281, \"rotX\": 0 } ]'),
(19, '[ { \"y\": 896.89453125, \"x\": 2123.037109375, \"dim\": 0, \"z\": 11.1796875, \"int\": 0, \"rotY\": 0, \"rotZ\": 178.956298828125, \"rotX\": 0 } ]'),
(20, '[ { \"y\": 1016.53125, \"x\": 2021.134765625, \"dim\": 0, \"z\": 10.8203125, \"int\": 0, \"rotY\": 0, \"rotZ\": 355.410400390625, \"rotX\": 0 } ]'),
(21, '[ { \"y\": 1411.494140625, \"x\": 2173.81640625, \"dim\": 0, \"z\": 11.0625, \"int\": 0, \"rotY\": 0, \"rotZ\": 268.9521484375, \"rotX\": 0 } ]'),
(22, '[ { \"y\": 1896.3349609375, \"x\": 2027.828125, \"dim\": 0, \"z\": 12.22519779205322, \"int\": 0, \"rotY\": 0, \"rotZ\": 178.868408203125, \"rotX\": 0 } ]'),
(23, '[ { \"y\": 1986.6611328125, \"x\": 2194.939453125, \"dim\": 0, \"z\": 12.296875, \"int\": 0, \"rotY\": 0, \"rotZ\": 270.7209777832031, \"rotX\": 0 } ]'),
(24, '[ { \"y\": 2076.05859375, \"x\": 2163.6728515625, \"dim\": 0, \"z\": 10.8203125, \"int\": 0, \"rotY\": 0, \"rotZ\": 269.9189758300781, \"rotX\": 0 } ]'),
(25, '[ { \"y\": 2232.505859375, \"x\": 2102.3046875, \"dim\": 0, \"z\": 11.0234375, \"int\": 0, \"rotY\": 0, \"rotZ\": 87.17510986328125, \"rotX\": 0 } ]'),
(26, '[ { \"y\": 2361.3740234375, \"x\": 2141.5224609375, \"dim\": 0, \"z\": 10.8203125, \"int\": 0, \"rotY\": 0, \"rotZ\": 0.15655517578125, \"rotX\": 0 } ]'),
(27, '[ { \"y\": 1722.8779296875, \"x\": 1662.923828125, \"dim\": 0, \"z\": 10.82811164855957, \"int\": 0, \"rotY\": 0, \"rotZ\": 0.964080810546875, \"rotX\": 0 } ]'),
(28, '[ { \"y\": 2219.0654296875, \"x\": 1593.6474609375, \"dim\": 0, \"z\": 11.06919479370117, \"int\": 0, \"rotY\": 0, \"rotZ\": 92.0091552734375, \"rotX\": 0 } ]'),
(29, '[ { \"y\": 2658.4775390625, \"x\": 1437.7529296875, \"dim\": 0, \"z\": 11.39261245727539, \"int\": 0, \"rotY\": 0, \"rotZ\": 270.0727844238281, \"rotX\": 0 } ]'),
(30, '[ { \"y\": 1720.578125, \"x\": 666.4775390625, \"dim\": 0, \"z\": 7.1875, \"int\": 0, \"rotY\": 0, \"rotZ\": 225.1105499267578, \"rotX\": 0 } ]'),
(31, '[ { \"y\": 1968.4892578125, \"x\": 697.3583984375, \"dim\": 0, \"z\": 5.537857055664062, \"int\": 0, \"rotY\": 0, \"rotZ\": 359.2666625976562, \"rotX\": 0 } ]'),
(32, '[ { \"y\": 1597.1884765625, \"x\": 1114.6640625, \"dim\": 0, \"z\": 12.546875, \"int\": 0, \"rotY\": 0, \"rotZ\": 272.2481079101562, \"rotX\": 0 } ]'),
(33, '[ { \"y\": 1073.982421875, \"x\": -180.892578125, \"dim\": 0, \"z\": 19.7421875, \"int\": 0, \"rotY\": 0, \"rotZ\": 267.974365234375, \"rotX\": 0 } ]'),
(34, '[ { \"y\": 1528.59375, \"x\": -856.5078125, \"dim\": 0, \"z\": 22.58704376220703, \"int\": 0, \"rotY\": 0, \"rotZ\": 91.674072265625, \"rotX\": 0 } ]'),
(35, '[ { \"y\": 2717.5380859375, \"x\": -1265.9287109375, \"dim\": 0, \"z\": 50.26628112792969, \"int\": 0, \"rotY\": 0, \"rotZ\": 30.03982543945312, \"rotX\": 0 } ]'),
(36, '[ { \"y\": 2320.34375, \"x\": -2453.794921875, \"dim\": 0, \"z\": 4.984375, \"int\": 0, \"rotY\": 0, \"rotZ\": 181.1096343994141, \"rotX\": 0 } ]'),
(37, '[ { \"y\": 958.7626953125, \"x\": -2420.1552734375, \"dim\": 0, \"z\": 45.296875, \"int\": 0, \"rotY\": 0, \"rotZ\": 90.62484741210938, \"rotX\": 0 } ]'),
(38, '[ { \"y\": 963.380859375, \"x\": -1770.783203125, \"dim\": 0, \"z\": 24.8828125, \"int\": 0, \"rotY\": 0, \"rotZ\": 359.5797729492188, \"rotX\": 0 } ]'),
(39, '[ { \"y\": 1015.6552734375, \"x\": -1520.9306640625, \"dim\": 0, \"z\": 7.1875, \"int\": 0, \"rotY\": 0, \"rotZ\": 355.9542236328125, \"rotX\": 0 } ]'),
(40, '[ { \"y\": 154.9775390625, \"x\": -1980.609375, \"dim\": 0, \"z\": 27.6875, \"int\": 0, \"rotY\": 0, \"rotZ\": 268.9356994628906, \"rotX\": 0 } ]'),
(41, '[ { \"y\": -169.6884765625, \"x\": -2430.8955078125, \"dim\": 0, \"z\": 35.3203125, \"int\": 0, \"rotY\": 0, \"rotZ\": 93.84939575195312, \"rotX\": 0 } ]'),
(42, '[ { \"y\": -308.0166015625, \"x\": -2708.275390625, \"dim\": 0, \"z\": 7.167653560638428, \"int\": 0, \"rotY\": 0, \"rotZ\": 223.1659545898438, \"rotX\": 0 } ]'),
(43, '[ { \"y\": 326.2197265625, \"x\": -2723.62109375, \"dim\": 0, \"z\": 4.367401123046875, \"int\": 0, \"rotY\": 0, \"rotZ\": 181.6699676513672, \"rotX\": 0 } ]'),
(44, '[ { \"y\": -264.49609375, \"x\": -1470.4892578125, \"dim\": 0, \"z\": 14.15443801879883, \"int\": 0, \"rotY\": 0, \"rotZ\": 79.10003662109375, \"rotX\": 0 } ]'),
(45, '[ { \"y\": -355.3642578125, \"x\": -1380.0224609375, \"dim\": 0, \"z\": 14.1484375, \"int\": 0, \"rotY\": 0, \"rotZ\": 193.7550964355469, \"rotX\": 0 } ]'),
(46, '[ { \"y\": -2445.7978515625, \"x\": -2160.0810546875, \"dim\": 0, \"z\": 30.625, \"int\": 0, \"rotY\": 0, \"rotZ\": 230.4170227050781, \"rotX\": 0 } ]'),
(47, '[ { \"y\": -2335.552734375, \"x\": 1625.7431640625, \"dim\": 0, \"z\": 13.54011631011963, \"int\": 0, \"rotY\": 0, \"rotZ\": 181.5161285400391, \"rotX\": 0 } ]'),
(48, '[ { \"y\": -2237.4912109375, \"x\": 1745.044921875, \"dim\": 0, \"z\": 13.55159950256348, \"int\": 0, \"rotY\": 0, \"rotZ\": 357.9702453613281, \"rotX\": 0 } ]'),
(49, '[ { \"y\": 1362.208984375, \"x\": 1713.818359375, \"dim\": 0, \"z\": 10.75207138061523, \"int\": 0, \"rotY\": 0, \"rotZ\": 172.4083251953125, \"rotX\": 0 } ]'),
(50, '[ { \"y\": 1529.556640625, \"x\": 1713.478515625, \"dim\": 0, \"z\": 10.75240898132324, \"int\": 0, \"rotY\": 0, \"rotZ\": 4.8148193359375, \"rotX\": 0 } ]');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cuentas`
--

CREATE TABLE `cuentas` (
  `ID` int(11) NOT NULL,
  `Usuario` varchar(255) NOT NULL,
  `Correo` varchar(255) NOT NULL,
  `Serial` text DEFAULT NULL,
  `Rango` int(11) NOT NULL,
  `IP` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `familias`
--

CREATE TABLE `familias` (
  `ID` int(11) NOT NULL,
  `Nombre` text NOT NULL,
  `Ubicacion` text NOT NULL,
  `Territorio` text NOT NULL,
  `Color` text NOT NULL,
  `Activo` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `familias`
--

INSERT INTO `familias` (`ID`, `Nombre`, `Ubicacion`, `Territorio`, `Color`, `Activo`) VALUES
(1, 'Libre', 'Libre', '[{}]', '[ { \"B\": 157, \"G\": 157, \"R\": 157 } ]', 'false'),
(2, 'Ganton', 'Ganton', '[ { \"Zone1\": {\"x\": 2224, \"y\": -1839, \"ancho\": 200, \"alto\": 150}}]', '[ { \"B\": 157, \"G\": 157, \"R\": 157 } ]', 'false'),
(3, 'GroveStreet', 'GroveStreet', '[ { \"Zone1\": {\"x\": 2228, \"y\": -1690, \"ancho\": 310, \"alto\": 100}, \"Zone2\": {\"x\": 2421, \"y\": -1725, \"ancho\": 116, \"alto\": 35}}]', '[ { \"B\": 157, \"G\": 157, \"R\": 157 } ]', 'false'),
(4, 'Money Wayy', 'Seville', '[ { \"Zone1\": {\"x\": 2620, \"y\": -2042, \"ancho\": 300, \"alto\": 150}}]', '[ { \"B\": 0, \"G\": 0, \"R\": 255 } ]', 'false'),
(5, 'Willowfield', 'Willowfield', '[ { \"Zone1\": {\"x\": 2406, \"y\": -2058, \"ancho\": 150, \"alto\": 200}}]', '[ { \"B\": 157, \"G\": 157, \"R\": 157 } ]', 'false'),
(6, 'BarrioWillow', 'BarrioWillow', '[ { \"Zone1\": {\"x\": 2204, \"y\": -2003, \"ancho\": 150, \"alto\": 150}}]', '[ { \"B\": 157, \"G\": 157, \"R\": 157 } ]', 'false'),
(7, 'Florencia 13', 'Corona', '[ { \"Zone1\": {\"x\": 1658, \"y\": -2156, \"ancho\": 305, \"alto\": 150}, \"Zone2\": {\"x\": 1811, \"y\": -2006, \"ancho\": 150, \"alto\": 125}}]', '[ { \"B\": 255, \"G\": 102, \"R\": 0 } ]', 'false'),
(8, 'Las Flores', 'Las Flores', '[ { \"Zone1\": {\"x\": 2559, \"y\": -1453, \"ancho\": 100, \"alto\": 270}, \"Zone2\": {\"x\": 2659, \"y\": -1390, \"ancho\": 75, \"alto\": 207}}]', '[ { \"B\": 157, \"G\": 157, \"R\": 157 } ]', 'false'),
(9, 'Las Colinas', 'Las Colinas', '[ { \"Zone1\": {\"x\": 1957, \"y\": -1053, \"ancho\": 122, \"alto\": 160}, \"Zone2\": {\"x\": 2079, \"y\": -1100, \"ancho\": 188, \"alto\": 207}, \"Zone3\":{\"x\": 2267, \"y\": -1162, \"ancho\": 600, \"alto\": 269}, \"Zone4\":{\"x\": 2185, \"y\": -1130, \"ancho\": 82, \"alto\": 30}}]', '[ { \"B\": 157, \"G\": 157, \"R\": 157 } ]', 'false'),
(10, 'Jefferson', 'Jefferson', '[ { \"Zone1\": {\"x\": 1980, \"y\": -1471, \"ancho\": 76, \"alto\": 120}, \"Zone2\": {\"x\": 2056, \"y\": -1475, \"ancho\": 47, \"alto\": 255}, \"Zone3\":{\"x\": 2103, \"y\": -1551, \"ancho\": 80, \"alto\": 331}, \"Zone4\":{\"x\": 2183, \"y\": -1550, \"ancho\": 85, \"alto\": 420}}]', '[ { \"B\": 157, \"G\": 157, \"R\": 157 } ]', 'false'),
(11, 'GlenPark', 'GlenPark', '[ { \"Zone1\": {\"x\": 1857, \"y\": -1456, \"ancho\": 125, \"alto\": 400}, \"Zone2\": {\"x\": 1982, \"y\": -1351, \"ancho\": 75, \"alto\": 295}, \"Zone3\":{\"x\": 2057, \"y\": -1220, \"ancho\": 125, \"alto\": 120}}]', '[ { \"B\": 157, \"G\": 157, \"R\": 157 } ]', 'false'),
(12, 'East Los Santos', 'East Los Santos', '[ { \"Zone1\": {\"x\": 2274, \"y\": -1549, \"ancho\": 280, \"alto\": 400}}]', '[ { \"B\": 157, \"G\": 157, \"R\": 157 } ]', 'false'),
(13, 'Idlewood', 'Idlewood', '[ { \"Zone1\": {\"x\": 1827, \"y\": -1882, \"ancho\": 370, \"alto\": 325}}]', '[ { \"B\": 157, \"G\": 157, \"R\": 157 } ]', 'false'),
(14, 'Temple', 'Temple', '[ { \"Zone1\": {\"x\": 970, \"y\": -1150, \"ancho\": 420, \"alto\": 275}}]', '[ { \"B\": 157, \"G\": 157, \"R\": 157 } ]', 'false'),
(15, 'La Confraternità di Pentangeli', 'Marina', '[ { \"Zone1\": {\"x\": 634, \"y\": -1800, \"ancho\": 290, \"alto\": 400}}]', '[ { \"B\": 61, \"G\": 61, \"R\": 61 } ]', 'false'),
(16, 'East Beach', 'East Beach', '[ { \"Zone1\": {\"x\": 2660, \"y\": -1900, \"ancho\": 300, \"alto\": 500}, \"Zone2\": {\"x\": 2735, \"y\": -1400, \"ancho\": 220, \"alto\": 220}}]', '[ { \"B\": 157, \"G\": 157, \"R\": 157 } ]', 'false'),
(17, 'Richman', 'Richman', '[ { \"Zone1\": {\"x\": 70, \"y\": -1550, \"ancho\": 100, \"alto\": 550}, \"Zone2\": {\"x\": 170, \"y\": -1480, \"ancho\": 50, \"alto\": 480}, \"Zone3\":{\"x\": 220, \"y\": -1427, \"ancho\": 50, \"alto\": 425}, \"Zone4\":{\"x\": 270, \"y\": -1381, \"ancho\": 100, \"alto\": 380}, \"Zone5\":{\"x\": 370, \"y\": -1312, \"ancho\": 100, \"alto\": 630}, \"Zone6\":{\"x\": 470, \"y\": -1250, \"ancho\": 200, \"alto\": 570}, \"Zone7\":{\"x\": 670, \"y\": -1100, \"ancho\": 120, \"alto\": 200}}]', '[ { \"B\": 124, \"G\": 124, \"R\": 124 } ]', 'false'),
(18, 'Solntsevskaya Bratva', 'Mulholland', '[ { \"Zone1\": {\"x\": 670, \"y\": -900, \"ancho\": 300, \"alto\": 250}, \"Zone2\": {\"x\": 970, \"y\": -875, \"ancho\": 700, \"alto\": 400}}]', '[ { \"B\": 0, \"G\": 0, \"R\": 126 } ]', 'false');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `familiasinteriores`
--

CREATE TABLE `familiasinteriores` (
  `id` int(11) NOT NULL,
  `IDFam` int(11) NOT NULL,
  `entrada_x` float NOT NULL,
  `entrada_y` float NOT NULL,
  `entrada_z` float NOT NULL,
  `entrada_int` int(11) NOT NULL,
  `entrada_dim` int(11) NOT NULL,
  `salida_x` float NOT NULL,
  `salida_y` float NOT NULL,
  `salida_z` float NOT NULL,
  `salida_int` int(11) NOT NULL,
  `salida_dim` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `familiasinteriores`
--

INSERT INTO `familiasinteriores` (`id`, `IDFam`, `entrada_x`, `entrada_y`, `entrada_z`, `entrada_int`, `entrada_dim`, `salida_x`, `salida_y`, `salida_z`, `salida_int`, `salida_dim`) VALUES
(1, 2, 2266.38, -1700.59, 13.6907, 0, 0, 318.512, 1115.41, 1083.88, 5, 2),
(2, 3, 2486.54, -1645.16, 14.0703, 0, 0, 318.512, 1115.41, 1083.88, 5, 3),
(3, 4, 2750.54, -2018.65, 13.5547, 0, 0, 318.512, 1115.41, 1083.88, 5, 4),
(4, 5, 2442.71, -1981.24, 13.5469, 0, 0, 318.512, 1115.41, 1083.88, 5, 5),
(5, 6, 2322.74, -1955.88, 13.5713, 0, 0, 318.512, 1115.41, 1083.88, 5, 6),
(6, 7, 1942.16, -2061.67, 13.5469, 0, 0, 318.512, 1115.41, 1083.88, 5, 7),
(7, 8, 2560.33, -1426.09, 24.4855, 0, 0, 318.512, 1115.41, 1083.88, 5, 8),
(8, 9, 2288.13, -1105.3, 37.9766, 0, 0, 318.512, 1115.41, 1083.88, 5, 9),
(9, 10, 2177.14, -1311.1, 23.9844, 0, 0, 318.512, 1115.41, 1083.88, 5, 10),
(10, 11, 1988.88, -1086.56, 24.7592, 0, 0, 318.512, 1115.41, 1083.88, 5, 11),
(11, 12, 2480.91, -1332.06, 28.1828, 0, 0, 318.512, 1115.41, 1083.88, 5, 12),
(12, 13, 1990.04, -1778.22, 17.3609, 0, 0, 318.512, 1115.41, 1083.88, 5, 13),
(13, 14, 1111.41, -975.823, 42.7656, 0, 0, 234.14, 1064.46, 1084.21, 6, 14),
(14, 15, 725.592, -1440.25, 13.5391, 0, 0, 234.14, 1064.46, 1084.21, 6, 15),
(15, 16, 2770.71, -1628.41, 12.1775, 0, 0, 234.14, 1064.46, 1084.21, 6, 16),
(16, 17, 228.221, -1409, 51.6094, 0, 0, 234.14, 1064.46, 1084.21, 6, 17),
(17, 18, 947.283, -708.549, 122.211, 0, 0, 234.14, 1064.46, 1084.21, 6, 18);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `familiasrangos`
--

CREATE TABLE `familiasrangos` (
  `ID` int(11) NOT NULL,
  `IDFam` int(11) NOT NULL,
  `IDRango` int(11) NOT NULL,
  `Nombre` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `familiasrangos`
--

INSERT INTO `familiasrangos` (`ID`, `IDFam`, `IDRango`, `Nombre`) VALUES
(2, 1, 1, 'Civil'),
(3, 2, 7, 'Líder'),
(4, 2, 6, 'Sub-Líder'),
(5, 2, 5, 'Capitán'),
(6, 2, 4, 'Teniente'),
(7, 2, 3, 'Sargento'),
(8, 2, 2, 'Soldado'),
(9, 2, 1, 'Recluta'),
(10, 3, 7, 'Líder'),
(11, 3, 6, 'Sub-Líder'),
(12, 3, 5, 'Capitán'),
(13, 3, 4, 'Teniente'),
(14, 3, 3, 'Sargento'),
(15, 3, 2, 'Soldado'),
(16, 3, 1, 'Recluta'),
(17, 4, 7, 'Father'),
(18, 4, 6, 'Boss'),
(19, 4, 5, 'Original'),
(20, 4, 4, 'Punisher'),
(21, 4, 3, 'Crook'),
(22, 4, 2, 'Soldier'),
(23, 4, 1, 'Shortie'),
(24, 5, 7, 'Líder'),
(25, 5, 6, 'Sub-Líder'),
(26, 5, 5, 'Capitán'),
(27, 5, 4, 'Teniente'),
(28, 5, 3, 'Sargento'),
(29, 5, 2, 'Soldado'),
(30, 5, 1, 'Recluta'),
(31, 6, 7, 'Líder'),
(32, 6, 6, 'Sub-Líder'),
(33, 6, 5, 'Capitán'),
(34, 6, 4, 'Teniente'),
(35, 6, 3, 'Sargento'),
(36, 6, 2, 'Soldado'),
(37, 6, 1, 'Recluta'),
(38, 7, 7, 'Shot Caller'),
(39, 7, 6, 'Second in Command'),
(40, 7, 5, 'Soldier'),
(41, 7, 4, 'OG'),
(42, 7, 3, 'Lil\'homie'),
(43, 7, 2, 'Youngster'),
(44, 7, 1, 'Hangaround'),
(45, 8, 7, 'Líder'),
(46, 8, 6, 'Sub-Líder'),
(47, 8, 5, 'Capitán'),
(48, 8, 4, 'Teniente'),
(49, 8, 3, 'Sargento'),
(50, 8, 2, 'Soldado'),
(51, 8, 1, 'Recluta'),
(52, 9, 7, 'Líder'),
(53, 9, 6, 'Sub-Líder'),
(54, 9, 5, 'Capitán'),
(55, 9, 4, 'Teniente'),
(56, 9, 3, 'Sargento'),
(57, 9, 2, 'Soldado'),
(58, 9, 1, 'Recluta'),
(59, 10, 7, 'Líder'),
(60, 10, 6, 'Sub-Líder'),
(61, 10, 5, 'Capitán'),
(62, 10, 4, 'Teniente'),
(63, 10, 3, 'Sargento'),
(64, 10, 2, 'Soldado'),
(65, 10, 1, 'Recluta'),
(66, 11, 7, 'Líder'),
(67, 11, 6, 'Sub-Líder'),
(68, 11, 5, 'Capitán'),
(69, 11, 4, 'Teniente'),
(70, 11, 3, 'Sargento'),
(71, 11, 2, 'Soldado'),
(72, 11, 1, 'Recluta'),
(73, 12, 7, 'Líder'),
(74, 12, 6, 'Sub-Líder'),
(75, 12, 5, 'Capitán'),
(76, 12, 4, 'Teniente'),
(77, 12, 3, 'Sargento'),
(78, 12, 2, 'Soldado'),
(79, 12, 1, 'Recluta'),
(80, 13, 7, 'Líder'),
(81, 13, 6, 'Sub-Líder'),
(82, 13, 5, 'Capitán'),
(83, 13, 4, 'Teniente'),
(84, 13, 3, 'Sargento'),
(85, 13, 2, 'Soldado'),
(86, 13, 1, 'Recluta'),
(87, 14, 7, 'Líder'),
(88, 14, 6, 'Sub-Líder'),
(89, 14, 5, 'Capitán'),
(90, 14, 4, 'Teniente'),
(91, 14, 3, 'Sargento'),
(92, 14, 2, 'Soldado'),
(93, 14, 1, 'Recluta'),
(94, 15, 7, 'Capo'),
(95, 15, 6, 'Sottocapo'),
(96, 15, 5, 'Consiglieri'),
(97, 15, 4, 'Caporegime'),
(98, 15, 3, 'Uccisoris'),
(99, 15, 2, 'Servizio'),
(100, 15, 1, 'Soldato'),
(101, 16, 7, 'Líder'),
(102, 16, 6, 'Sub-Líder'),
(103, 16, 5, 'Capitán'),
(104, 16, 4, 'Teniente'),
(105, 16, 3, 'Sargento'),
(106, 16, 2, 'Soldado'),
(107, 16, 1, 'Recluta'),
(108, 17, 7, 'Don'),
(109, 17, 6, 'Lacroix'),
(110, 17, 5, 'Cúpula'),
(111, 17, 4, 'Advisor'),
(112, 17, 3, 'Crew leader'),
(113, 17, 2, 'Enforcer'),
(114, 17, 1, 'Affiliate'),
(115, 18, 7, 'Líder'),
(116, 18, 6, 'Sub-Líder'),
(117, 18, 5, 'Consejal'),
(118, 18, 4, 'Consejero'),
(119, 18, 3, 'Sicario'),
(120, 18, 2, 'Mafioso'),
(121, 18, 1, 'Aprendiz');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `familiasusers`
--

CREATE TABLE `familiasusers` (
  `ID` int(11) NOT NULL,
  `Personajes` int(11) NOT NULL DEFAULT 0,
  `Familia` int(11) NOT NULL DEFAULT 0,
  `Rango` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `familiasvehiculos`
--

CREATE TABLE `familiasvehiculos` (
  `ID` int(11) NOT NULL,
  `IDFamilia` int(11) NOT NULL,
  `INFORMACION` varchar(500) NOT NULL DEFAULT '',
  `ESTADO` varchar(500) NOT NULL DEFAULT '',
  `UBICACION` varchar(500) NOT NULL DEFAULT '0',
  `TUNNING` varchar(500) NOT NULL DEFAULT '',
  `INVENTARIO` varchar(10000) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `familiasvehiculos`
--

INSERT INTO `familiasvehiculos` (`ID`, `IDFamilia`, `INFORMACION`, `ESTADO`, `UBICACION`, `TUNNING`, `INVENTARIO`) VALUES
(1, 1, '[ { \"Modelo\": 0, \"Matricula\": \"Fam1-01\" } ]', '[ { \"Salud\": 1000, \"Destruido\": false, \"Bloqueo\": true, \"Luces\": false, \"Motor\": false } ]', '[ { \"rotX\": 0, \"rotY\": 0, \"posY\": 0, \"posX\": 0, \"Interior\": 0, \"posZ\": 0, \"rotZ\": 0, \"Dimension\": 0 } ]', '[ { \"Color\": { \"G1\": 157, \"G0\": 157, \"G3\": 157, \"G2\": 157, \"B3\": 157, \"B0\": 157, \"B2\": 157, \"B1\": 157, \"R0\": 157, \"R1\": 157, \"R2\": 157, \"R3\": 157 }, \"Luces\": { \"B\": 255, \"G\": 255, \"R\": 255 }, \"Paintjob\": 0, \"Modificaciones\": [ ] } ]', '[ { \"Slot 7\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 10\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 6\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 8\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 3\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 4\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 2\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 5\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 9\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 1\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" } } ]'),
(2, 1, '[ { \"Modelo\": 0, \"Matricula\": \"Fam1-02\" } ]', '[ { \"Salud\": 1000, \"Destruido\": false, \"Bloqueo\": true, \"Luces\": false, \"Motor\": false } ]', '[ { \"rotX\": 0, \"rotY\": 0, \"posY\": 0, \"posX\": 0, \"Interior\": 0, \"posZ\": 0, \"rotZ\": 0, \"Dimension\": 0 } ]', '[ { \"Color\": { \"G1\": 157, \"G0\": 157, \"G3\": 157, \"G2\": 157, \"B3\": 157, \"B0\": 157, \"B2\": 157, \"B1\": 157, \"R0\": 157, \"R1\": 157, \"R2\": 157, \"R3\": 157 }, \"Luces\": { \"B\": 255, \"G\": 255, \"R\": 255 }, \"Paintjob\": 0, \"Modificaciones\": [ ] } ]', '[ { \"Slot 7\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 10\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 6\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 8\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 3\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 4\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 2\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 5\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 9\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 1\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" } } ]'),
(3, 2, '[ { \"Modelo\": 566, \"Matricula\": \"Fam2-01\" } ]', '[ { \"Salud\": 1000, \"Destruido\": false, \"Bloqueo\": true, \"Luces\": false, \"Motor\": false } ]', '[ { \"rotX\": 0, \"rotY\": 0, \"posY\": 0, \"posX\": 0, \"Interior\": 0, \"posZ\": 0, \"rotZ\": 0, \"Dimension\": 0 } ]', '[ { \"Color\": { \"G1\": 157, \"G0\": 157, \"G3\": 157, \"G2\": 157, \"B3\": 157, \"B0\": 157, \"B2\": 157, \"B1\": 157, \"R0\": 157, \"R1\": 157, \"R2\": 157, \"R3\": 157 }, \"Luces\": { \"B\": 255, \"G\": 255, \"R\": 255 }, \"Paintjob\": 0, \"Modificaciones\": [ ] } ]', '[ { \"Slot 7\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 10\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 6\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 8\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 3\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 4\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 2\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 5\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 9\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 1\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" } } ]'),
(4, 2, '[ { \"Modelo\": 567, \"Matricula\": \"Fam2-02\" } ]', '[ { \"Salud\": 1000, \"Destruido\": false, \"Bloqueo\": true, \"Luces\": false, \"Motor\": false } ]', '[ { \"rotX\": 0, \"rotY\": 0, \"posY\": 0, \"posX\": 0, \"Interior\": 0, \"posZ\": 0, \"rotZ\": 0, \"Dimension\": 0 } ]', '[ { \"Color\": { \"G1\": 157, \"G0\": 157, \"G3\": 157, \"G2\": 157, \"B3\": 157, \"B0\": 157, \"B2\": 157, \"B1\": 157, \"R0\": 157, \"R1\": 157, \"R2\": 157, \"R3\": 157 }, \"Luces\": { \"B\": 255, \"G\": 255, \"R\": 255 }, \"Paintjob\": 0, \"Modificaciones\": [ ] } ]', '[ { \"Slot 7\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 10\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 6\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 8\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 3\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 4\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 2\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 5\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 9\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 1\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" } } ]'),
(5, 3, '[ { \"Modelo\": 566, \"Matricula\": \"Fam3-01\" } ]', '[ { \"Salud\": 1000, \"Destruido\": false, \"Bloqueo\": true, \"Luces\": false, \"Motor\": false } ]', '[ { \"rotX\": 0, \"rotY\": 0, \"posY\": -1667, \"posX\": 2508, \"Interior\": 0, \"posZ\": 13, \"rotZ\": 10, \"Dimension\": 0 } ]', '[ { \"Color\": { \"G1\": 157, \"G0\": 157, \"G3\": 157, \"G2\": 157, \"B3\": 157, \"B0\": 157, \"B2\": 157, \"B1\": 157, \"R0\": 157, \"R1\": 157, \"R2\": 157, \"R3\": 157 }, \"Luces\": { \"B\": 255, \"G\": 255, \"R\": 255 }, \"Paintjob\": 0, \"Modificaciones\": [ ] } ]', '[ { \"Slot 7\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 10\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 6\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 8\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 3\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 4\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 2\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 5\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 9\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 1\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" } } ]'),
(6, 3, '[ { \"Modelo\": 567, \"Matricula\": \"Fam3-02\" } ]', '[ { \"Salud\": 1000, \"Destruido\": false, \"Bloqueo\": true, \"Luces\": false, \"Motor\": false } ]', '[ { \"rotX\": 0, \"rotY\": 0, \"posY\": -1682, \"posX\": 2490, \"Interior\": 0, \"posZ\": 16, \"rotZ\": 270, \"Dimension\": 0 } ]', '[ { \"Color\": { \"G1\": 157, \"G0\": 157, \"G3\": 157, \"G2\": 157, \"B3\": 157, \"B0\": 157, \"B2\": 157, \"B1\": 157, \"R0\": 157, \"R1\": 157, \"R2\": 157, \"R3\": 157 }, \"Luces\": { \"B\": 255, \"G\": 255, \"R\": 255 }, \"Paintjob\": 0, \"Modificaciones\": [ ] } ]', '[ { \"Slot 7\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 10\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 6\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 8\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 3\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 4\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 2\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 5\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 9\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 1\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" } } ]'),
(7, 4, '[ { \"Modelo\": 566, \"Matricula\": \"Fam4-01\" } ]', '[ { \"Salud\": 1000, \"Destruido\": false, \"Bloqueo\": true, \"Luces\": false, \"Motor\": false } ]', '[ { \"rotX\": 0, \"rotY\": 0, \"posY\": -1998, \"posX\": 2787, \"Interior\": 0, \"posZ\": 13, \"rotZ\": 90, \"Dimension\": 0 } ]', '[ { \"Color\": { \"G1\": 0, \"G0\": 0, \"G3\": 0, \"G2\": 0, \"B3\": 0, \"B0\": 0, \"B2\": 0, \"B1\": 0, \"R0\": 0, \"R1\": 255, \"R2\": 255, \"R3\": 255 }, \"Luces\": { \"B\": 255, \"G\": 255, \"R\": 255 }, \"Paintjob\": 3, \"Modificaciones\": [ [ 1081 ] ] } ]', '[ { \"Slot 7\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 10\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 6\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 8\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 3\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 4\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 2\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 5\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 9\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 1\": { \"Objeto\": \"Ninguno\", \"Cantidad\": 0 } } ]'),
(8, 4, '[ { \"Modelo\": 567, \"Matricula\": \"Fam4-02\" } ]', '[ { \"Salud\": 1000, \"Destruido\": false, \"Bloqueo\": true, \"Luces\": false, \"Motor\": false } ]', '[ { \"rotX\": 0, \"rotY\": 0, \"posY\": -1991, \"posX\": 2783, \"Interior\": 0, \"posZ\": 13, \"rotZ\": 90, \"Dimension\": 0 } ]', '[ { \"Color\": { \"G1\": 0, \"G0\": 0, \"G3\": 0, \"G2\": 0, \"B3\": 0, \"B0\": 0, \"B2\": 0, \"B1\": 0, \"R0\": 0, \"R1\": 255, \"R2\": 255, \"R3\": 255 }, \"Luces\": { \"B\": 255, \"G\": 255, \"R\": 255 }, \"Paintjob\": 3, \"Modificaciones\": [ [ ] ] } ]', '[ { \"Slot 7\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 10\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 6\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 8\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 3\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 4\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 2\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 5\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 9\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 1\": { \"Objeto\": \"Ninguno\", \"Cantidad\": 0 } } ]'),
(9, 5, '[ { \"Modelo\": 566, \"Matricula\": \"Fam5-01\" } ]', '[ { \"Salud\": 1000, \"Destruido\": false, \"Bloqueo\": true, \"Luces\": false, \"Motor\": false } ]', '[ { \"rotX\": 0, \"rotY\": 0, \"posY\": 0, \"posX\": 0, \"Interior\": 0, \"posZ\": 0, \"rotZ\": 0, \"Dimension\": 0 } ]', '[ { \"Color\": { \"G1\": 157, \"G0\": 157, \"G3\": 157, \"G2\": 157, \"B3\": 157, \"B0\": 157, \"B2\": 157, \"B1\": 157, \"R0\": 157, \"R1\": 157, \"R2\": 157, \"R3\": 157 }, \"Luces\": { \"B\": 255, \"G\": 255, \"R\": 255 }, \"Paintjob\": 0, \"Modificaciones\": [ ] } ]', '[ { \"Slot 7\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 10\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 6\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 8\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 3\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 4\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 2\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 5\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 9\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 1\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" } } ]'),
(10, 5, '[ { \"Modelo\": 567, \"Matricula\": \"Fam5-02\" } ]', '[ { \"Salud\": 1000, \"Destruido\": false, \"Bloqueo\": true, \"Luces\": false, \"Motor\": false } ]', '[ { \"rotX\": 0, \"rotY\": 0, \"posY\": 0, \"posX\": 0, \"Interior\": 0, \"posZ\": 0, \"rotZ\": 0, \"Dimension\": 0 } ]', '[ { \"Color\": { \"G1\": 157, \"G0\": 157, \"G3\": 157, \"G2\": 157, \"B3\": 157, \"B0\": 157, \"B2\": 157, \"B1\": 157, \"R0\": 157, \"R1\": 157, \"R2\": 157, \"R3\": 157 }, \"Luces\": { \"B\": 255, \"G\": 255, \"R\": 255 }, \"Paintjob\": 0, \"Modificaciones\": [ ] } ]', '[ { \"Slot 7\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 10\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 6\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 8\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 3\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 4\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 2\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 5\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 9\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 1\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" } } ]'),
(11, 6, '[ { \"Modelo\": 566, \"Matricula\": \"Fam6-01\" } ]', '[ { \"Salud\": 1000, \"Destruido\": false, \"Bloqueo\": true, \"Luces\": false, \"Motor\": false } ]', '[ { \"rotX\": 0, \"rotY\": 0, \"posY\": 0, \"posX\": 0, \"Interior\": 0, \"posZ\": 0, \"rotZ\": 0, \"Dimension\": 0 } ]', '[ { \"Color\": { \"G1\": 157, \"G0\": 157, \"G3\": 157, \"G2\": 157, \"B3\": 157, \"B0\": 157, \"B2\": 157, \"B1\": 157, \"R0\": 157, \"R1\": 157, \"R2\": 157, \"R3\": 157 }, \"Luces\": { \"B\": 255, \"G\": 255, \"R\": 255 }, \"Paintjob\": 0, \"Modificaciones\": [ ] } ]', '[ { \"Slot 7\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 10\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 6\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 8\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 3\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 4\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 2\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 5\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 9\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 1\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" } } ]'),
(12, 6, '[ { \"Modelo\": 567, \"Matricula\": \"Fam6-02\" } ]', '[ { \"Salud\": 1000, \"Destruido\": false, \"Bloqueo\": true, \"Luces\": false, \"Motor\": false } ]', '[ { \"rotX\": 0, \"rotY\": 0, \"posY\": 0, \"posX\": 0, \"Interior\": 0, \"posZ\": 0, \"rotZ\": 0, \"Dimension\": 0 } ]', '[ { \"Color\": { \"G1\": 157, \"G0\": 157, \"G3\": 157, \"G2\": 157, \"B3\": 157, \"B0\": 157, \"B2\": 157, \"B1\": 157, \"R0\": 157, \"R1\": 157, \"R2\": 157, \"R3\": 157 }, \"Luces\": { \"B\": 255, \"G\": 255, \"R\": 255 }, \"Paintjob\": 0, \"Modificaciones\": [ ] } ]', '[ { \"Slot 7\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 10\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 6\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 8\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 3\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 4\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 2\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 5\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 9\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 1\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" } } ]'),
(13, 7, '[ { \"Modelo\": 567, \"Matricula\": \"Fam7-01\" } ]', '[ { \"Salud\": 1000, \"Destruido\": false, \"Bloqueo\": true, \"Luces\": false, \"Motor\": false } ]', '[ { \"rotX\": 0, \"rotY\": 0, \"posY\": -2021, \"posX\": 1879, \"Interior\": 0, \"posZ\": 13, \"rotZ\": 180, \"Dimension\": 0 } ]', '[ { \"Color\": { \"G1\": 102, \"G0\": 102, \"G3\": 102, \"G2\": 102, \"B3\": 255, \"B0\": 255, \"B2\": 255, \"B1\": 255, \"R0\": 0, \"R1\": 0, \"R2\": 0, \"R3\": 0 }, \"Luces\": { \"B\": 255, \"G\": 255, \"R\": 255 }, \"Paintjob\": 0, \"Modificaciones\": [ [ 1163, 1133, 1131, 1010, 1087, 1086, 1098, 1132, 1189, 1187 ] ] } ]', '[ { \"Slot 7\": { \"Objeto\": \"Ninguno\", \"Cantidad\": 0 }, \"Slot 10\": { \"Objeto\": \"Ninguno\", \"Cantidad\": 0 }, \"Slot 6\": { \"Objeto\": \"Ninguno\", \"Cantidad\": 0 }, \"Slot 8\": { \"Objeto\": \"Ninguno\", \"Cantidad\": 0 }, \"Slot 3\": { \"Objeto\": \"Ninguno\", \"Cantidad\": 0 }, \"Slot 4\": { \"Objeto\": \"Ninguno\", \"Cantidad\": 0 }, \"Slot 2\": { \"Objeto\": \"Ninguno\", \"Cantidad\": 0 }, \"Slot 5\": { \"Objeto\": \"Ninguno\", \"Cantidad\": 0 }, \"Slot 9\": { \"Objeto\": \"Ninguno\", \"Cantidad\": 0 }, \"Slot 1\": { \"Objeto\": \"Ninguno\", \"Cantidad\": 0 } } ]'),
(14, 7, '[ { \"Modelo\": 566, \"Matricula\": \"Fam7-02\" } ]', '[ { \"Salud\": 1000, \"Destruido\": false, \"Bloqueo\": true, \"Luces\": false, \"Motor\": false } ]', '[ { \"rotX\": 0, \"rotY\": 0, \"posY\": -2021, \"posX\": 1886, \"Interior\": 0, \"posZ\": 13, \"rotZ\": 0, \"Dimension\": 0 } ]', '[ { \"Color\": { \"G1\": 102, \"G0\": 102, \"G3\": 102, \"G2\": 102, \"B3\": 255, \"B0\": 255, \"B2\": 255, \"B1\": 255, \"R0\": 0, \"R1\": 0, \"R2\": 0, \"R3\": 0 }, \"Luces\": { \"B\": 255, \"G\": 255, \"R\": 255 }, \"Paintjob\": 0, \"Modificaciones\": [ [ ] ] } ]', '[ { \"Slot 7\": { \"Objeto\": \"Ninguno\", \"Cantidad\": 0 }, \"Slot 10\": { \"Objeto\": \"Ninguno\", \"Cantidad\": 0 }, \"Slot 6\": { \"Objeto\": \"Ninguno\", \"Cantidad\": 0 }, \"Slot 8\": { \"Objeto\": \"Ninguno\", \"Cantidad\": 0 }, \"Slot 3\": { \"Objeto\": \"Ninguno\", \"Cantidad\": 0 }, \"Slot 4\": { \"Objeto\": \"Ninguno\", \"Cantidad\": 0 }, \"Slot 2\": { \"Objeto\": \"Ninguno\", \"Cantidad\": 0 }, \"Slot 5\": { \"Objeto\": \"Ninguno\", \"Cantidad\": 0 }, \"Slot 9\": { \"Objeto\": \"Ninguno\", \"Cantidad\": 0 }, \"Slot 1\": { \"Objeto\": \"Ninguno\", \"Cantidad\": 0 } } ]'),
(15, 8, '[ { \"Modelo\": 566, \"Matricula\": \"Fam8-01\" } ]', '[ { \"Salud\": 1000, \"Destruido\": false, \"Bloqueo\": true, \"Luces\": false, \"Motor\": false } ]', '[ { \"rotX\": 0, \"rotY\": 0, \"posY\": 0, \"posX\": 0, \"Interior\": 0, \"posZ\": 0, \"rotZ\": 0, \"Dimension\": 0 } ]', '[ { \"Color\": { \"G1\": 157, \"G0\": 157, \"G3\": 157, \"G2\": 157, \"B3\": 157, \"B0\": 157, \"B2\": 157, \"B1\": 157, \"R0\": 157, \"R1\": 157, \"R2\": 157, \"R3\": 157 }, \"Luces\": { \"B\": 255, \"G\": 255, \"R\": 255 }, \"Paintjob\": 0, \"Modificaciones\": [ ] } ]', '[ { \"Slot 7\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 10\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 6\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 8\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 3\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 4\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 2\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 5\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 9\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 1\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" } } ]'),
(16, 8, '[ { \"Modelo\": 567, \"Matricula\": \"Fam8-02\" } ]', '[ { \"Salud\": 1000, \"Destruido\": false, \"Bloqueo\": true, \"Luces\": false, \"Motor\": false } ]', '[ { \"rotX\": 0, \"rotY\": 0, \"posY\": 0, \"posX\": 0, \"Interior\": 0, \"posZ\": 0, \"rotZ\": 0, \"Dimension\": 0 } ]', '[ { \"Color\": { \"G1\": 157, \"G0\": 157, \"G3\": 157, \"G2\": 157, \"B3\": 157, \"B0\": 157, \"B2\": 157, \"B1\": 157, \"R0\": 157, \"R1\": 157, \"R2\": 157, \"R3\": 157 }, \"Luces\": { \"B\": 255, \"G\": 255, \"R\": 255 }, \"Paintjob\": 0, \"Modificaciones\": [ ] } ]', '[ { \"Slot 7\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 10\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 6\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 8\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 3\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 4\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 2\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 5\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 9\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 1\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" } } ]'),
(17, 9, '[ { \"Modelo\": 566, \"Matricula\": \"Fam9-01\" } ]', '[ { \"Salud\": 1000, \"Destruido\": false, \"Bloqueo\": true, \"Luces\": false, \"Motor\": false } ]', '[ { \"rotX\": 0, \"rotY\": 0, \"posY\": 0, \"posX\": 0, \"Interior\": 0, \"posZ\": 0, \"rotZ\": 0, \"Dimension\": 0 } ]', '[ { \"Color\": { \"G1\": 157, \"G0\": 157, \"G3\": 157, \"G2\": 157, \"B3\": 157, \"B0\": 157, \"B2\": 157, \"B1\": 157, \"R0\": 157, \"R1\": 157, \"R2\": 157, \"R3\": 157 }, \"Luces\": { \"B\": 255, \"G\": 255, \"R\": 255 }, \"Paintjob\": 0, \"Modificaciones\": [ ] } ]', '[ { \"Slot 7\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 10\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 6\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 8\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 3\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 4\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 2\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 5\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 9\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 1\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" } } ]'),
(18, 9, '[ { \"Modelo\": 567, \"Matricula\": \"Fam9-02\" } ]', '[ { \"Salud\": 1000, \"Destruido\": false, \"Bloqueo\": true, \"Luces\": false, \"Motor\": false } ]', '[ { \"rotX\": 0, \"rotY\": 0, \"posY\": 0, \"posX\": 0, \"Interior\": 0, \"posZ\": 0, \"rotZ\": 0, \"Dimension\": 0 } ]', '[ { \"Color\": { \"G1\": 157, \"G0\": 157, \"G3\": 157, \"G2\": 157, \"B3\": 157, \"B0\": 157, \"B2\": 157, \"B1\": 157, \"R0\": 157, \"R1\": 157, \"R2\": 157, \"R3\": 157 }, \"Luces\": { \"B\": 255, \"G\": 255, \"R\": 255 }, \"Paintjob\": 0, \"Modificaciones\": [ ] } ]', '[ { \"Slot 7\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 10\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 6\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 8\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 3\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 4\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 2\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 5\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 9\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 1\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" } } ]'),
(19, 10, '[ { \"Modelo\": 566, \"Matricula\": \"Fam10-01\" } ]', '[ { \"Salud\": 1000, \"Destruido\": false, \"Bloqueo\": true, \"Luces\": false, \"Motor\": false } ]', '[ { \"rotX\": 0, \"rotY\": 0, \"posY\": 0, \"posX\": 0, \"Interior\": 0, \"posZ\": 0, \"rotZ\": 0, \"Dimension\": 0 } ]', '[ { \"Color\": { \"G1\": 157, \"G0\": 157, \"G3\": 157, \"G2\": 157, \"B3\": 157, \"B0\": 157, \"B2\": 157, \"B1\": 157, \"R0\": 157, \"R1\": 157, \"R2\": 157, \"R3\": 157 }, \"Luces\": { \"B\": 255, \"G\": 255, \"R\": 255 }, \"Paintjob\": 0, \"Modificaciones\": [ ] } ]', '[ { \"Slot 7\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 10\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 6\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 8\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 3\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 4\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 2\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 5\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 9\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 1\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" } } ]'),
(20, 10, '[ { \"Modelo\": 567, \"Matricula\": \"Fam10-02\" } ]', '[ { \"Salud\": 1000, \"Destruido\": false, \"Bloqueo\": true, \"Luces\": false, \"Motor\": false } ]', '[ { \"rotX\": 0, \"rotY\": 0, \"posY\": 0, \"posX\": 0, \"Interior\": 0, \"posZ\": 0, \"rotZ\": 0, \"Dimension\": 0 } ]', '[ { \"Color\": { \"G1\": 157, \"G0\": 157, \"G3\": 157, \"G2\": 157, \"B3\": 157, \"B0\": 157, \"B2\": 157, \"B1\": 157, \"R0\": 157, \"R1\": 157, \"R2\": 157, \"R3\": 157 }, \"Luces\": { \"B\": 255, \"G\": 255, \"R\": 255 }, \"Paintjob\": 0, \"Modificaciones\": [ ] } ]', '[ { \"Slot 7\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 10\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 6\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 8\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 3\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 4\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 2\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 5\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 9\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 1\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" } } ]'),
(21, 11, '[ { \"Modelo\": 566, \"Matricula\": \"Fam11-01\" } ]', '[ { \"Salud\": 1000, \"Destruido\": false, \"Bloqueo\": true, \"Luces\": false, \"Motor\": false } ]', '[ { \"rotX\": 0, \"rotY\": 0, \"posY\": 0, \"posX\": 0, \"Interior\": 0, \"posZ\": 0, \"rotZ\": 0, \"Dimension\": 0 } ]', '[ { \"Color\": { \"G1\": 157, \"G0\": 157, \"G3\": 157, \"G2\": 157, \"B3\": 157, \"B0\": 157, \"B2\": 157, \"B1\": 157, \"R0\": 157, \"R1\": 157, \"R2\": 157, \"R3\": 157 }, \"Luces\": { \"B\": 255, \"G\": 255, \"R\": 255 }, \"Paintjob\": 0, \"Modificaciones\": [ ] } ]', '[ { \"Slot 7\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 10\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 6\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 8\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 3\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 4\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 2\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 5\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 9\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 1\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" } } ]'),
(22, 11, '[ { \"Modelo\": 567, \"Matricula\": \"Fam11-02\" } ]', '[ { \"Salud\": 1000, \"Destruido\": false, \"Bloqueo\": true, \"Luces\": false, \"Motor\": false } ]', '[ { \"rotX\": 0, \"rotY\": 0, \"posY\": 0, \"posX\": 0, \"Interior\": 0, \"posZ\": 0, \"rotZ\": 0, \"Dimension\": 0 } ]', '[ { \"Color\": { \"G1\": 157, \"G0\": 157, \"G3\": 157, \"G2\": 157, \"B3\": 157, \"B0\": 157, \"B2\": 157, \"B1\": 157, \"R0\": 157, \"R1\": 157, \"R2\": 157, \"R3\": 157 }, \"Luces\": { \"B\": 255, \"G\": 255, \"R\": 255 }, \"Paintjob\": 0, \"Modificaciones\": [ ] } ]', '[ { \"Slot 7\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 10\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 6\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 8\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 3\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 4\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 2\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 5\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 9\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 1\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" } } ]'),
(23, 12, '[ { \"Modelo\": 566, \"Matricula\": \"Fam12-01\" } ]', '[ { \"Salud\": 1000, \"Destruido\": false, \"Bloqueo\": true, \"Luces\": false, \"Motor\": false } ]', '[ { \"rotX\": 0, \"rotY\": 0, \"posY\": 0, \"posX\": 0, \"Interior\": 0, \"posZ\": 0, \"rotZ\": 0, \"Dimension\": 0 } ]', '[ { \"Color\": { \"G1\": 157, \"G0\": 157, \"G3\": 157, \"G2\": 157, \"B3\": 157, \"B0\": 157, \"B2\": 157, \"B1\": 157, \"R0\": 157, \"R1\": 157, \"R2\": 157, \"R3\": 157 }, \"Luces\": { \"B\": 255, \"G\": 255, \"R\": 255 }, \"Paintjob\": 0, \"Modificaciones\": [ ] } ]', '[ { \"Slot 7\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 10\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 6\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 8\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 3\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 4\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 2\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 5\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 9\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 1\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" } } ]'),
(24, 12, '[ { \"Modelo\": 567, \"Matricula\": \"Fam12-02\" } ]', '[ { \"Salud\": 1000, \"Destruido\": false, \"Bloqueo\": true, \"Luces\": false, \"Motor\": false } ]', '[ { \"rotX\": 0, \"rotY\": 0, \"posY\": 0, \"posX\": 0, \"Interior\": 0, \"posZ\": 0, \"rotZ\": 0, \"Dimension\": 0 } ]', '[ { \"Color\": { \"G1\": 157, \"G0\": 157, \"G3\": 157, \"G2\": 157, \"B3\": 157, \"B0\": 157, \"B2\": 157, \"B1\": 157, \"R0\": 157, \"R1\": 157, \"R2\": 157, \"R3\": 157 }, \"Luces\": { \"B\": 255, \"G\": 255, \"R\": 255 }, \"Paintjob\": 0, \"Modificaciones\": [ ] } ]', '[ { \"Slot 7\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 10\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 6\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 8\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 3\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 4\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 2\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 5\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 9\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 1\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" } } ]'),
(25, 13, '[ { \"Modelo\": 566, \"Matricula\": \"Fam13-01\" } ]', '[ { \"Salud\": 1000, \"Destruido\": false, \"Bloqueo\": true, \"Luces\": false, \"Motor\": false } ]', '[ { \"rotX\": 0, \"rotY\": 0, \"posY\": 0, \"posX\": 0, \"Interior\": 0, \"posZ\": 0, \"rotZ\": 0, \"Dimension\": 0 } ]', '[ { \"Color\": { \"G1\": 157, \"G0\": 157, \"G3\": 157, \"G2\": 157, \"B3\": 157, \"B0\": 157, \"B2\": 157, \"B1\": 157, \"R0\": 157, \"R1\": 157, \"R2\": 157, \"R3\": 157 }, \"Luces\": { \"B\": 255, \"G\": 255, \"R\": 255 }, \"Paintjob\": 0, \"Modificaciones\": [ ] } ]', '[ { \"Slot 7\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 10\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 6\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 8\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 3\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 4\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 2\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 5\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 9\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 1\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" } } ]'),
(26, 13, '[ { \"Modelo\": 567, \"Matricula\": \"Fam13-02\" } ]', '[ { \"Salud\": 1000, \"Destruido\": false, \"Bloqueo\": true, \"Luces\": false, \"Motor\": false } ]', '[ { \"rotX\": 0, \"rotY\": 0, \"posY\": 0, \"posX\": 0, \"Interior\": 0, \"posZ\": 0, \"rotZ\": 0, \"Dimension\": 0 } ]', '[ { \"Color\": { \"G1\": 157, \"G0\": 157, \"G3\": 157, \"G2\": 157, \"B3\": 157, \"B0\": 157, \"B2\": 157, \"B1\": 157, \"R0\": 157, \"R1\": 157, \"R2\": 157, \"R3\": 157 }, \"Luces\": { \"B\": 255, \"G\": 255, \"R\": 255 }, \"Paintjob\": 0, \"Modificaciones\": [ ] } ]', '[ { \"Slot 7\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 10\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 6\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 8\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 3\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 4\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 2\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 5\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 9\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 1\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" } } ]'),
(27, 14, '[ { \"Modelo\": 579, \"Matricula\": \"Fam14-01\" } ]', '[ { \"Salud\": 1000, \"Destruido\": false, \"Bloqueo\": true, \"Luces\": false, \"Motor\": false } ]', '[ { \"rotX\": 0, \"rotY\": 0, \"posY\": 0, \"posX\": 0, \"Interior\": 0, \"posZ\": 0, \"rotZ\": 0, \"Dimension\": 0 } ]', '[ { \"Color\": { \"G1\": 157, \"G0\": 157, \"G3\": 157, \"G2\": 157, \"B3\": 157, \"B0\": 157, \"B2\": 157, \"B1\": 157, \"R0\": 157, \"R1\": 157, \"R2\": 157, \"R3\": 157 }, \"Luces\": { \"B\": 255, \"G\": 255, \"R\": 255 }, \"Paintjob\": 0, \"Modificaciones\": [ ] } ]', '[ { \"Slot 7\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 10\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 6\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 8\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 3\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 4\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 2\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 5\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 9\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 1\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" } } ]'),
(28, 14, '[ { \"Modelo\": 426, \"Matricula\": \"Fam14-02\" } ]', '[ { \"Salud\": 1000, \"Destruido\": false, \"Bloqueo\": true, \"Luces\": false, \"Motor\": false } ]', '[ { \"rotX\": 0, \"rotY\": 0, \"posY\": 0, \"posX\": 0, \"Interior\": 0, \"posZ\": 0, \"rotZ\": 0, \"Dimension\": 0 } ]', '[ { \"Color\": { \"G1\": 157, \"G0\": 157, \"G3\": 157, \"G2\": 157, \"B3\": 157, \"B0\": 157, \"B2\": 157, \"B1\": 157, \"R0\": 157, \"R1\": 157, \"R2\": 157, \"R3\": 157 }, \"Luces\": { \"B\": 255, \"G\": 255, \"R\": 255 }, \"Paintjob\": 0, \"Modificaciones\": [ ] } ]', '[ { \"Slot 7\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 10\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 6\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 8\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 3\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 4\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 2\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 5\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 9\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 1\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" } } ]'),
(29, 15, '[ { \"Modelo\": 579, \"Matricula\": \"Fam15-01\" } ]', '[ { \"Salud\": 1000, \"Destruido\": false, \"Bloqueo\": true, \"Luces\": false, \"Motor\": false } ]', '[ { \"rotX\": 0, \"rotY\": 0, \"posY\": -1433, \"posX\": 735, \"Interior\": 0, \"posZ\": 14, \"rotZ\": 268, \"Dimension\": 0 } ]', '[ { \"Color\": { \"G1\": 157, \"G0\": 157, \"G3\": 157, \"G2\": 157, \"B3\": 157, \"B0\": 157, \"B2\": 157, \"B1\": 157, \"R0\": 157, \"R1\": 157, \"R2\": 157, \"R3\": 157 }, \"Luces\": { \"B\": 255, \"G\": 255, \"R\": 255 }, \"Paintjob\": 0, \"Modificaciones\": [ [ ] ] } ]', '[ { \"Slot 7\": { \"Objeto\": \"Ninguno\", \"Cantidad\": 0 }, \"Slot 10\": { \"Objeto\": \"Ninguno\", \"Cantidad\": 0 }, \"Slot 6\": { \"Objeto\": \"Ninguno\", \"Cantidad\": 0 }, \"Slot 8\": { \"Objeto\": \"Ninguno\", \"Cantidad\": 0 }, \"Slot 3\": { \"Objeto\": \"Ninguno\", \"Cantidad\": 0 }, \"Slot 4\": { \"Objeto\": \"Ninguno\", \"Cantidad\": 0 }, \"Slot 2\": { \"Objeto\": \"Ninguno\", \"Cantidad\": 0 }, \"Slot 5\": { \"Objeto\": \"Ninguno\", \"Cantidad\": 0 }, \"Slot 9\": { \"Objeto\": \"Ninguno\", \"Cantidad\": 0 }, \"Slot 1\": { \"Objeto\": \"Ninguno\", \"Cantidad\": 0 } } ]'),
(30, 15, '[ { \"Modelo\": 426, \"Matricula\": \"Fam15-02\" } ]', '[ { \"Salud\": 1000, \"Destruido\": false, \"Bloqueo\": true, \"Luces\": false, \"Motor\": false } ]', '[ { \"rotX\": 0, \"rotY\": 0, \"posY\": -1433, \"posX\": 720, \"Interior\": 0, \"posZ\": 14, \"rotZ\": 85, \"Dimension\": 0 } ]', '[ { \"Color\": { \"G1\": 157, \"G0\": 157, \"G3\": 157, \"G2\": 157, \"B3\": 157, \"B0\": 157, \"B2\": 157, \"B1\": 157, \"R0\": 157, \"R1\": 157, \"R2\": 157, \"R3\": 157 }, \"Luces\": { \"B\": 255, \"G\": 255, \"R\": 255 }, \"Paintjob\": 0, \"Modificaciones\": [ [ ] ] } ]', '[ { \"Slot 7\": { \"Objeto\": \"Ninguno\", \"Cantidad\": 0 }, \"Slot 10\": { \"Objeto\": \"Ninguno\", \"Cantidad\": 0 }, \"Slot 6\": { \"Objeto\": \"Ninguno\", \"Cantidad\": 0 }, \"Slot 8\": { \"Objeto\": \"Ninguno\", \"Cantidad\": 0 }, \"Slot 3\": { \"Objeto\": \"Ninguno\", \"Cantidad\": 0 }, \"Slot 4\": { \"Objeto\": \"Ninguno\", \"Cantidad\": 0 }, \"Slot 2\": { \"Objeto\": \"Ninguno\", \"Cantidad\": 0 }, \"Slot 5\": { \"Objeto\": \"Ninguno\", \"Cantidad\": 0 }, \"Slot 9\": { \"Objeto\": \"Ninguno\", \"Cantidad\": 0 }, \"Slot 1\": { \"Objeto\": \"Ninguno\", \"Cantidad\": 0 } } ]'),
(31, 16, '[ { \"Modelo\": 579, \"Matricula\": \"Fam16-01\" } ]', '[ { \"Salud\": 1000, \"Destruido\": false, \"Bloqueo\": true, \"Luces\": false, \"Motor\": false } ]', '[ { \"rotX\": 0, \"rotY\": 0, \"posY\": 0, \"posX\": 0, \"Interior\": 0, \"posZ\": 0, \"rotZ\": 0, \"Dimension\": 0 } ]', '[ { \"Color\": { \"G1\": 157, \"G0\": 157, \"G3\": 157, \"G2\": 157, \"B3\": 157, \"B0\": 157, \"B2\": 157, \"B1\": 157, \"R0\": 157, \"R1\": 157, \"R2\": 157, \"R3\": 157 }, \"Luces\": { \"B\": 255, \"G\": 255, \"R\": 255 }, \"Paintjob\": 0, \"Modificaciones\": [ ] } ]', '[ { \"Slot 7\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 10\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 6\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 8\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 3\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 4\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 2\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 5\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 9\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 1\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" } } ]'),
(32, 16, '[ { \"Modelo\": 426, \"Matricula\": \"Fam16-02\" } ]', '[ { \"Salud\": 1000, \"Destruido\": false, \"Bloqueo\": true, \"Luces\": false, \"Motor\": false } ]', '[ { \"rotX\": 0, \"rotY\": 0, \"posY\": 0, \"posX\": 0, \"Interior\": 0, \"posZ\": 0, \"rotZ\": 0, \"Dimension\": 0 } ]', '[ { \"Color\": { \"G1\": 157, \"G0\": 157, \"G3\": 157, \"G2\": 157, \"B3\": 157, \"B0\": 157, \"B2\": 157, \"B1\": 157, \"R0\": 157, \"R1\": 157, \"R2\": 157, \"R3\": 157 }, \"Luces\": { \"B\": 255, \"G\": 255, \"R\": 255 }, \"Paintjob\": 0, \"Modificaciones\": [ ] } ]', '[ { \"Slot 7\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 10\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 6\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 8\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 3\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 4\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 2\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 5\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 9\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 1\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" } } ]'),
(33, 17, '[ { \"Modelo\": 579, \"Matricula\": \"Fam17-01\" } ]', '[ { \"Salud\": 1000, \"Destruido\": false, \"Bloqueo\": true, \"Luces\": false, \"Motor\": false } ]', '[ { \"rotX\": 0, \"rotY\": 0, \"posY\": -1402, \"posX\": 232, \"Interior\": 0, \"posZ\": 51, \"rotZ\": 60, \"Dimension\": 0 } ]', '[ { \"Color\": { \"G1\": 0, \"G0\": 22, \"G3\": 0, \"G2\": 0, \"B3\": 0, \"B0\": 22, \"B2\": 0, \"B1\": 0, \"R0\": 22, \"R1\": 0, \"R2\": 0, \"R3\": 0 }, \"Luces\": { \"B\": 255, \"G\": 255, \"R\": 255 }, \"Paintjob\": 3, \"Modificaciones\": [ [ 1010 ] ] } ]', '[ { \"Slot 7\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 10\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 6\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 8\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 3\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 4\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 2\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 5\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 9\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 1\": { \"Cantidad\": 17, \"Objeto\": \"Colt 45\" } } ]'),
(34, 17, '[ { \"Modelo\": 426, \"Matricula\": \"Fam17-02\" } ]', '[ { \"Salud\": 1000, \"Destruido\": false, \"Bloqueo\": true, \"Luces\": false, \"Motor\": false } ]', '[ { \"rotX\": 0, \"rotY\": 0, \"posY\": -1404.3857421875, \"posX\": 216.6162109375, \"Interior\": 0, \"posZ\": 51.352615356445, \"rotZ\": 331.64834594727, \"Dimension\": 0 } ]', '[ { \"Color\": { \"G1\": 0, \"G0\": 22, \"G3\": 0, \"G2\": 0, \"B3\": 0, \"B0\": 22, \"B2\": 0, \"B1\": 0, \"R0\": 22, \"R1\": 0, \"R2\": 0, \"R3\": 0 }, \"Luces\": { \"B\": 255, \"G\": 255, \"R\": 255 }, \"Paintjob\": 3, \"Modificaciones\": [ [ 1010, 1019 ] ] } ]', '[ { \"Slot 7\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 10\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 6\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 8\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 3\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 4\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 2\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 5\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 9\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 1\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" } } ]'),
(35, 18, '[ { \"Modelo\": 579, \"Matricula\": \"Fam18-01\" } ]', '[ { \"Salud\": 1000, \"Destruido\": false, \"Bloqueo\": true, \"Luces\": false, \"Motor\": false } ]', '[ { \"rotX\": 0, \"rotY\": 0, \"posY\": -693, \"posX\": 951, \"Interior\": 0, \"posZ\": 122, \"rotZ\": 120, \"Dimension\": 0 } ]', '[ { \"Color\": { \"G1\": 157, \"G0\": 157, \"G3\": 157, \"G2\": 157, \"B3\": 157, \"B0\": 157, \"B2\": 157, \"B1\": 157, \"R0\": 157, \"R1\": 157, \"R2\": 157, \"R3\": 157 }, \"Luces\": { \"B\": 255, \"G\": 255, \"R\": 255 }, \"Paintjob\": 0, \"Modificaciones\": [ [ ] ] } ]', '[ { \"Slot 7\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 10\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 6\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 8\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 3\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 4\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 2\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 5\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 9\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 1\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" } } ]'),
(36, 18, '[ { \"Modelo\": 426, \"Matricula\": \"Fam18-02\" } ]', '[ { \"Salud\": 1000, \"Destruido\": false, \"Bloqueo\": true, \"Luces\": false, \"Motor\": false } ]', '[ { \"rotX\": 0, \"rotY\": 0, \"posY\": -707, \"posX\": 940, \"Interior\": 0, \"posZ\": 122, \"rotZ\": 34, \"Dimension\": 0 } ]', '[ { \"Color\": { \"G1\": 157, \"G0\": 157, \"G3\": 157, \"G2\": 157, \"B3\": 157, \"B0\": 157, \"B2\": 157, \"B1\": 157, \"R0\": 157, \"R1\": 157, \"R2\": 157, \"R3\": 157 }, \"Luces\": { \"B\": 255, \"G\": 255, \"R\": 255 }, \"Paintjob\": 0, \"Modificaciones\": [ [ ] ] } ]', '[ { \"Slot 7\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 10\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 6\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 8\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 3\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 4\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 2\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 5\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 9\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" }, \"Slot 1\": { \"Cantidad\": 0, \"Objeto\": \"Ninguno\" } } ]');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `interiores`
--

CREATE TABLE `interiores` (
  `id` int(11) NOT NULL,
  `entrada_x` float NOT NULL,
  `entrada_y` float NOT NULL,
  `entrada_z` float NOT NULL,
  `entrada_int` int(11) NOT NULL,
  `entrada_dim` int(11) NOT NULL,
  `salida_x` float NOT NULL,
  `salida_y` float NOT NULL,
  `salida_z` float NOT NULL,
  `salida_int` int(11) NOT NULL,
  `salida_dim` int(11) NOT NULL,
  `blip` int(11) NOT NULL,
  `descripcion` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `interiores`
--

INSERT INTO `interiores` (`id`, `entrada_x`, `entrada_y`, `entrada_z`, `entrada_int`, `entrada_dim`, `salida_x`, `salida_y`, `salida_z`, `salida_int`, `salida_dim`, `blip`, `descripcion`) VALUES
(1, 1172.7, -1325.3, 15.4, 0, 0, 1858, -1760.8, 1111.3, 9, 0, 22, 'Hospital Market'),
(2, 1498.5, -1581, 13.5, 0, 0, -2026.9, -104.5, 1035.2, 3, 0, 42, 'Trabajos LS'),
(3, 1554.8, -1675.5, 16.2, 0, 0, 246.7, 63.3, 1003.6, 6, 0, 30, 'Comisaria LS'),
(4, 1111.5, -1795.5, 16.6, 0, 0, -2026.9, -104.5, 1035.2, 3, 1, 53, 'Licencias Marina'),
(5, 2244.5, -1664.9, 15.5, 0, 0, 207.6, -111, 1005.1, 15, 0, 45, 'Tienda de ropa Binco'),
(6, 2112.8, -1212.1, 24, 0, 0, 203.7, -50.1, 1001.8, 1, 0, 45, 'Tienda de ropa SubUrban'),
(7, 499.8, -1359.9, 16.3, 0, 0, 206.9, -139.8, 1003.5, 3, 0, 45, 'Tienda de ropa ProLabs'),
(8, 1456.7, -1138.1, 24, 0, 0, 161.4, -96.5, 1001.8, 18, 0, 45, 'Tienda de ropa Zip'),
(9, 460.8, -1500.9, 31.1, 0, 0, 226.7, -8.2, 1002.2, 5, 0, 45, 'Tienda de ropa Victim'),
(10, 453.2, -1478.4, 30.8, 0, 0, 204.3, -168.6, 1000.5, 14, 0, 45, 'Tienda de ropa DidierShachs'),
(11, 2400.5, -1981.5, 13.5, 0, 0, 316.5, -168.5, 999.5, 6, 0, 6, 'Ammunation Willow'),
(12, 1367.5, -1279.5, 13.5, 0, 0, 285.5, -41.5, 1001.5, 1, 0, 6, 'Ammunation Market'),
(13, 2333.5, 61.5, 26.5, 0, 0, 296.5, -111.5, 1001.5, 6, 0, 6, 'Ammunation Palomino'),
(14, 242.5, -178.5, 1.5, 0, 0, 285.5, -85.5, 1001.5, 4, 0, 6, 'Ammunation Blueberry'),
(15, 1832.93, -1842.56, 13.58, 0, 0, -26.85, -57.18, 1003.55, 6, 0, 17, '24/7 #1'),
(16, 1315.44, -898.6, 39.58, 0, 0, -30.96, -90.99, 1003.55, 18, 0, 17, '24/7 #2'),
(17, 2001.79, -1761.4, 13.54, 0, 0, -27.36, -30.98, 1003.56, 4, 0, 17, '24/7 #3'),
(18, 2423.42, -1742.13, 13.55, 0, 0, -26.85, -57.18, 1003.55, 6, 1, 17, '24/7 #4'),
(19, 1446.15, -1261.11, 13.55, 0, 0, -27.36, -30.98, 1003.56, 4, 1, 17, '24/7 #5'),
(20, 2175.35, -1333.57, 23.98, 0, 0, -26.85, -57.18, 1003.55, 6, 2, 17, '24/7 #6'),
(21, 2714.05, -1108.75, 69.58, 0, 0, -30.96, -90.99, 1003.55, 18, 1, 17, '24/7 #7'),
(22, 773.21, -1793.5, 13.02, 0, 0, -30.96, -90.99, 1003.55, 18, 2, 17, '24/7 #8'),
(23, 332.28, -1337.8, 14.51, 0, 0, -26.85, -57.18, 1003.55, 6, 3, 17, '24/7 #9'),
(24, 1352.19, -1757.97, 13.51, 0, 0, -30.96, -90.99, 1003.55, 18, 3, 17, '24/7 #10'),
(25, 1975.81, -2036.8, 13.55, 0, 0, -26.85, -57.18, 1003.55, 6, 4, 17, '24/7 #11'),
(26, 2423.67, -1922.64, 13.55, 0, 0, -30.96, -90.99, 1003.55, 18, 4, 17, '24/7 #12'),
(27, 2249.52, 52.68, 26.67, 0, 0, -27.36, -30.98, 1003.56, 4, 2, 17, '24/7 #13'),
(28, 1258.42, 204.04, 19.72, 0, 0, -26.85, -57.18, 1003.55, 6, 5, 17, '24/7 #14'),
(29, 273.2, -180.7, 1.58, 0, 0, -26.85, -57.18, 1003.55, 6, 6, 17, '24/7 #15'),
(30, 691.35, -546.77, 16.34, 0, 0, -27.36, -30.98, 1003.56, 4, 3, 17, '24/7 #16'),
(31, 2723.82, -2026.6, 13.5472, 0, 0, 418.567, -83.7627, 1001.8, 3, 1, 7, 'Barbería 1'),
(32, 2071.41, -1793.88, 13.5533, 0, 0, 418.567, -83.7627, 1001.8, 3, 2, 7, 'Barbería 2'),
(33, 823.37, -1589.09, 13.5545, 0, 0, 418.567, -83.7627, 1001.8, 3, 3, 7, 'Barbería 3'),
(34, 672.82, -496.92, 16.3359, 0, 0, 418.567, -83.7627, 1001.8, 3, 4, 7, 'Barbería 4'),
(35, 2069.25, -1779.93, 13.5593, 0, 0, -204.279, -8.2549, 1002.27, 17, 0, 39, 'Tienda de Tatuajes LS'),
(36, 2309.72, -1644.03, 14.827, 0, 0, 501.891, -68.3262, 998.758, 11, 1, 49, 'BarLS 1'),
(37, 2348.48, -1373.33, 24.3984, 0, 0, 501.891, -68.3262, 998.758, 11, 2, 49, 'BarLS 2'),
(38, 2091.06, -972.815, 51.9451, 0, 0, 501.891, -68.3262, 998.758, 11, 3, 49, 'BarLS 3'),
(39, 875.838, -968.5, 37.1875, 0, 0, 501.891, -68.3262, 998.758, 11, 4, 49, 'BarLS 4'),
(40, 2104.46, -1806.51, 13.5547, 0, 0, 372.388, -132.883, 1001.49, 5, 1, 29, 'Pizzería LS 1'),
(41, 203.448, -202.72, 1.57812, 0, 0, 372.388, -132.883, 1001.49, 5, 2, 29, 'Pizzería LS 2'),
(42, 1366.73, 248.808, 19.5669, 0, 0, 372.388, -132.883, 1001.49, 5, 3, 29, 'Pizzería SF'),
(43, 2332.87, 75.0059, 26.621, 0, 0, 372.388, -132.883, 1001.49, 5, 4, 29, 'Pizzería Palomino'),
(44, 2397.92, -1898.6, 13.5469, 0, 0, 364.955, -11.2432, 1001.85, 9, 1, 14, 'Cluckin Bell LS 1'),
(45, 2420.33, -1508.99, 24, 0, 0, 364.955, -11.2432, 1001.85, 9, 2, 14, 'Cluckin Bell LS 2'),
(46, 928.062, -1352.82, 13.3438, 0, 0, 364.955, -11.2432, 1001.85, 9, 3, 14, 'Cluckin Bell SF'),
(47, 1199.38, -918.929, 43.1164, 0, 0, 363.515, -74.626, 1001.51, 10, 1, 10, 'Burger Shot LS'),
(48, 811.145, -1616.18, 13.5469, 0, 0, 363.515, -74.626, 1001.51, 10, 2, 10, 'Burger Shot LV'),
(49, 2232.6, -1159.83, 25.89, 0, 0, 2215.14, -1150.47, 1025.79, 15, 0, 41, 'Motel Jefferson');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `jailicdisconnect`
--

CREATE TABLE `jailicdisconnect` (
  `ID` int(11) NOT NULL,
  `Personaje` varchar(255) NOT NULL,
  `PD` varchar(255) NOT NULL,
  `Tiempo` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `jailoocdisconnect`
--

CREATE TABLE `jailoocdisconnect` (
  `ID` int(11) NOT NULL,
  `IDPersonaje` int(11) NOT NULL,
  `Staff` varchar(255) NOT NULL,
  `Tiempo` int(11) NOT NULL,
  `Razon` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `jailoochistory`
--

CREATE TABLE `jailoochistory` (
  `ID` int(11) NOT NULL,
  `IDPersonaje` int(11) NOT NULL,
  `Staff` varchar(255) NOT NULL,
  `Fecha` varchar(255) NOT NULL,
  `Razon` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `jobs`
--

CREATE TABLE `jobs` (
  `ID` int(11) NOT NULL,
  `Nombre` text NOT NULL,
  `Ubicacion` text NOT NULL,
  `Activo` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `jobs`
--

INSERT INTO `jobs` (`ID`, `Nombre`, `Ubicacion`, `Activo`) VALUES
(1, 'Desempleado', '[ { \"x\": 1498, \"y\": -1581, \"z\": 13 } ]', 'true'),
(2, 'Pizzero Idlewood', '[ { \"x\": 2108, \"y\": -1788, \"z\": 13 } ]', 'true'),
(3, 'Basurero LS', '[ { \"x\": 2441, \"y\": -2122, \"z\": 13 } ]', 'true'),
(4, 'Camionero LS', '[ { \"x\": 2183, \"y\": -2253, \"z\": 14 } ]', 'true');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `jobsrangos`
--

CREATE TABLE `jobsrangos` (
  `ID` int(11) NOT NULL,
  `IDJob` int(11) NOT NULL,
  `IDRango` int(11) NOT NULL,
  `Nombre` varchar(255) NOT NULL,
  `Salario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `jobsrangos`
--

INSERT INTO `jobsrangos` (`ID`, `IDJob`, `IDRango`, `Nombre`, `Salario`) VALUES
(1, 1, 1, 'Vago', 500),
(2, 2, 1, 'Pizzero Nivel 1', 293),
(3, 2, 2, 'Pizzero Nivel 2', 352),
(4, 2, 3, 'Pizzero Nivel 3', 422),
(5, 2, 4, 'Pizzero Nivel 4', 506),
(6, 2, 5, 'Pizzero Nivel 5', 608),
(7, 2, 6, 'Pizzero Nivel 6', 729),
(8, 2, 7, 'Pizzero Nivel 7', 875),
(9, 3, 1, 'Basurero Nivel 1', 670),
(10, 3, 2, 'Basurero Nivel 2', 804),
(11, 3, 3, 'Basurero Nivel 3', 965),
(12, 3, 4, 'Basurero Nivel 4', 1157),
(13, 3, 5, 'Basurero Nivel 5', 1389),
(14, 3, 6, 'Basurero Nivel 6', 1667),
(15, 3, 7, 'Basurero Nivel 7', 2000),
(16, 4, 1, 'Camionero Nivel 1', 670),
(17, 4, 2, 'Camionero Nivel 2', 804),
(18, 4, 3, 'Camionero Nivel 3', 965),
(19, 4, 4, 'Camionero Nivel 4', 1157),
(20, 4, 5, 'Camionero Nivel 5', 1389),
(21, 4, 6, 'Camionero Nivel 6', 1667),
(22, 4, 7, 'Camionero Nivel 7', 2000);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `jobsusers`
--

CREATE TABLE `jobsusers` (
  `ID` int(11) NOT NULL,
  `IDPersonaje` int(11) NOT NULL DEFAULT 0,
  `IDJob` int(11) NOT NULL DEFAULT 0,
  `IDRango` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `licencias`
--

CREATE TABLE `licencias` (
  `ID` int(11) NOT NULL,
  `Nombre` varchar(255) NOT NULL,
  `Tipo` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `licencias`
--

INSERT INTO `licencias` (`ID`, `Nombre`, `Tipo`) VALUES
(1, 'Licencia Moto', 'Vehiculo'),
(2, 'Licencia Coche', 'Vehiculo'),
(3, 'Licencia Camion', 'Vehiculo'),
(4, 'Licencia Barco', 'Maritimo'),
(5, 'Licencia Helicoptero', 'Aereo'),
(6, 'Licencia Avion', 'Aereo'),
(7, 'Licencia Armas', 'Arma'),
(8, 'Licencia Armas Avanzadas', 'Arma');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `multasic`
--

CREATE TABLE `multasic` (
  `ID` int(11) NOT NULL,
  `IDPersonaje` int(11) NOT NULL,
  `IDLSPD` int(11) NOT NULL,
  `PRECIO` int(11) NOT NULL,
  `MOTIVO` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `npcrobos`
--

CREATE TABLE `npcrobos` (
  `id` int(11) NOT NULL,
  `posX` float NOT NULL,
  `posY` float NOT NULL,
  `posZ` float NOT NULL,
  `rotX` float NOT NULL,
  `rotY` float NOT NULL,
  `rotZ` float NOT NULL,
  `Interior` int(11) NOT NULL,
  `Dimension` int(11) NOT NULL,
  `blipx` float NOT NULL,
  `blipy` float NOT NULL,
  `blipz` float NOT NULL,
  `descripcion` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `npcrobos`
--

INSERT INTO `npcrobos` (`id`, `posX`, `posY`, `posZ`, `rotX`, `rotY`, `rotZ`, `Interior`, `Dimension`, `blipx`, `blipy`, `blipz`, `descripcion`) VALUES
(101, 208.86, -98.7, 1005.25, 0, 0, 178.56, 15, 0, 2244.5, -1664.9, 15.5, 'Tienda de ropa Binco'),
(102, 203.85, -41.2, 1001.8, 0, 0, 180.11, 1, 0, 2112.8, -1212.1, 24, 'Tienda de ropa SubUrban'),
(103, 207, -127.8, 1003.5, 0, 0, 179.46, 3, 0, 499.8, -1359.9, 16.3, 'Tienda de ropa ProLabs'),
(104, 161.34, -81.19, 1001.8, 0, 0, 180.32, 18, 0, 1456.7, -1138.1, 24, 'Tienda de ropa Zip'),
(105, 204.85, -8.06, 1001.21, 0, 0, 269.14, 5, 0, 460.8, -1500.9, 31.1, 'Tienda de ropa Victim'),
(106, 204.2, -157.83, 1000.52, 0, 0, 182.58, 14, 0, 453.2, -1478.4, 30.8, 'Tienda de ropa DidierShachs'),
(111, -23.54, -57.31, 1003.54, 0, 0, 356.62, 6, 0, 1832.93, -1842.56, 13.58, '24/7 #1'),
(112, -27.93, -91.6367, 1003.54, 0, 0, 2.26, 18, 0, 1315.44, -898.6, 39.58, '24/7 #2'),
(113, -30.62, -30.68, 1003.55, 0, 0, 3.82, 4, 0, 2001.79, -1761.4, 13.54, '24/7 #3'),
(114, -23.54, -57.31, 1003.54, 0, 0, 356.62, 6, 1, 2423.42, -1742.13, 13.55, '24/7 #4'),
(115, -30.62, -30.68, 1003.56, 0, 0, 3.82, 4, 1, 1446.15, -1261.11, 13.55, '24/7 #5'),
(116, -23.54, -57.31, 1003.54, 0, 0, 356.62, 6, 2, 2175.35, -1333.57, 23.98, '24/7 #6'),
(117, -27.93, -91.6367, 1003.54, 0, 0, 2.26, 18, 1, 2714.05, -1108.75, 69.58, '24/7 #7'),
(118, -27.93, -91.6367, 1003.54, 0, 0, 2.26, 18, 2, 773.21, -1793.5, 13.02, '24/7 #8'),
(119, -23.54, -57.31, 1003.54, 0, 0, 356.62, 6, 3, 332.28, -1337.8, 14.51, '24/7 #9'),
(120, -27.93, -91.6367, 1003.54, 0, 0, 2.26, 18, 3, 1352.19, -1757.97, 13.51, '24/7 #10'),
(121, -23.54, -57.31, 1003.54, 0, 0, 356.62, 6, 4, 1975.81, -2036.8, 13.55, '24/7 #11'),
(122, -27.93, -91.6367, 1003.54, 0, 0, 2.26, 18, 4, 2423.67, -1922.64, 13.55, '24/7 #12'),
(123, -30.62, -30.68, 1003.55, 0, 0, 3.82, 4, 2, 2249.52, 52.68, 26.67, '24/7 #13'),
(124, -23.54, -57.31, 1003.54, 0, 0, 356.62, 6, 5, 1258.42, 204.04, 19.72, '24/7 #14'),
(125, -23.54, -57.31, 1003.54, 0, 0, 356.62, 6, 6, 273.2, -180.7, 1.58, '24/7 #15'),
(126, -30.62, -30.68, 1003.55, 0, 0, 3.82, 4, 3, 691.35, -546.77, 16.34, '24/7 #16'),
(127, 421.68, -75.49, 1001.81, 0, 0, 177.29, 3, 1, 2723.82, -2026.6, 13.5472, 'Barbería 1'),
(128, 421.68, -75.49, 1001.81, 0, 0, 177.29, 3, 2, 2071.41, -1793.88, 13.5533, 'Barbería 2'),
(129, 421.68, -75.49, 1001.81, 0, 0, 177.29, 3, 3, 823.37, -1589.09, 13.5545, 'Barbería 3'),
(130, 421.68, -75.49, 1001.81, 0, 0, 177.29, 3, 4, 672.82, -496.92, 16.3359, 'Barbería 4'),
(131, -201.12, -5.22, 1002.27, 0, 0, 134.8, 17, 0, 2069.25, -1779.93, 13.5593, 'Tienda de Tatuajes LS'),
(132, 497.65, -77.46, 998.76, 0, 0, 2.1, 11, 1, 2309.72, -1644.03, 14.827, 'BarLS 1'),
(133, 497.65, -77.46, 998.76, 0, 0, 2.1, 11, 2, 2348.48, -1373.33, 24.3984, 'BarLS 2'),
(134, 497.65, -77.46, 998.76, 0, 0, 2.1, 11, 3, 2091.06, -972.815, 51.9451, 'BarLS 3'),
(135, 497.65, -77.46, 998.76, 0, 0, 2.1, 11, 4, 875.838, -968.5, 37.1875, 'BarLS 4'),
(136, 374.64, -117.27, 1001.49, 0, 0, 179.38, 5, 1, 2104.46, -1806.51, 13.5547, 'Pizzería LS 1'),
(137, 374.64, -117.27, 1001.49, 0, 0, 179.38, 5, 2, 203.448, -202.72, 1.57812, 'Pizzería LS 2'),
(138, 374.64, -117.27, 1001.49, 0, 0, 179.38, 5, 3, 1366.73, 248.808, 19.5669, 'Pizzería SF'),
(139, 374.64, -117.27, 1001.49, 0, 0, 179.38, 5, 4, 2332.87, 75.0059, 26.621, 'Pizzería Palomino'),
(140, 368.14, -4.49, 1001.85, 0, 0, 181.93, 9, 1, 2397.92, -1898.6, 13.5469, 'Cluckin Bell LS 1'),
(141, 368.14, -4.49, 1001.85, 0, 0, 181.93, 9, 2, 2420.33, -1508.99, 24, 'Cluckin Bell LS 2'),
(142, 368.14, -4.49, 1001.85, 0, 0, 181.93, 9, 3, 928.062, -1352.82, 13.3438, 'Cluckin Bell SF'),
(143, 376.58, -65.84, 1001.5, 0, 0, 181.93, 10, 1, 1199.38, -918.929, 43.1164, 'Burger Shot LS'),
(144, 376.58, -65.84, 1001.5, 0, 0, 181.93, 10, 2, 811.145, -1616.18, 13.5469, 'Burger Shot LV');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personajes`
--

CREATE TABLE `personajes` (
  `ID` int(11) NOT NULL,
  `Cuenta` varchar(255) NOT NULL,
  `Nombre` varchar(255) NOT NULL,
  `Informacion` varchar(255) NOT NULL,
  `Estado` varchar(255) NOT NULL,
  `Ubicacion` varchar(255) NOT NULL,
  `Inventario` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `propiedades`
--

CREATE TABLE `propiedades` (
  `ID` int(11) NOT NULL,
  `IDPropietario` int(11) NOT NULL,
  `IDInquilino` int(11) NOT NULL,
  `Estado` varchar(255) NOT NULL,
  `Precio` varchar(255) NOT NULL,
  `Ubicacion` varchar(255) NOT NULL,
  `Bloqueo` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `propiedades`
--

INSERT INTO `propiedades` (`ID`, `IDPropietario`, `IDInquilino`, `Estado`, `Precio`, `Ubicacion`, `Bloqueo`) VALUES
(1, 0, 0, 'En Venta', '[ { \"Propietario\": 0, \"Estado\": \"1000\" } ]', '[ { \"Salida\": { \"Y\": 1366.1875, \"X\": 140.2646484375, \"Z\": 1083.859375, \"DIM\": 1, \"INT\": 5 }, \"Entrada\": { \"Y\": -1690.8193359375, \"X\": 2495.3544921875, \"Z\": 14.765625, \"DIM\": 0, \"INT\": 0 } } ]', 'true');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rangos`
--

CREATE TABLE `rangos` (
  `ID` int(11) NOT NULL,
  `Rango` varchar(255) NOT NULL,
  `Abreviatura` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `rangos`
--

INSERT INTO `rangos` (`ID`, `Rango`, `Abreviatura`) VALUES
(1, 'Usuario', 'USER'),
(2, 'Donador', 'Donador'),
(3, 'Soporte a Prueba', 'SOP.APrueba'),
(4, 'Soporte', 'SOP'),
(5, 'Super Soporte', 'S.SOP'),
(6, 'Administrador de Empresas', 'ADM Emp'),
(7, 'Administrador de Familias', 'ADM Fam'),
(8, 'Administrador de Facciones', 'ADM Facc'),
(9, 'Administrador de Staff', 'ADM Staff'),
(10, 'Owner', 'OWNER');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `telefonos`
--

CREATE TABLE `telefonos` (
  `ID` int(11) NOT NULL,
  `PersonajeID` int(11) NOT NULL,
  `Telefono` varchar(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `trabajos`
--

CREATE TABLE `trabajos` (
  `ID` int(11) NOT NULL,
  `Nombre` varchar(255) NOT NULL,
  `Activo` varchar(255) NOT NULL,
  `Posicion` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `trabajos`
--

INSERT INTO `trabajos` (`ID`, `Nombre`, `Activo`, `Posicion`) VALUES
(1, 'Desempleado', 'true', '[ { \"x\": 1498, \"y\": -1581, \"z\": 13 } ]'),
(2, 'Los Santos Police Departament', 'false', '[ { \"x\": 1554, \"y\": -1675, \"z\": 16 } ]'),
(3, 'Los Santos Emergency Services', 'false', '[ { \"x\": 1172, \"y\": -1325, \"z\": 15 } ]'),
(4, 'Los Santos Justice Departament', 'false', '[ { \"x\": 1798, \"y\": -1578, \"z\": 14 } ]'),
(5, 'ROSS Custom Garage', 'false', '[ { \"x\": 2097, \"y\": -1920, \"z\": 17 } ]'),
(6, 'Sanctuary Garage', 'false', '[ { \"x\": 1109, \"y\": -1187, \"z\": 22 } ]'),
(7, 'GoldenWrench', 'false', '[ { \"x\": 119, \"y\": -198, \"z\": 1 } ]'),
(8, 'Pizzero Idlewood', 'true', '[ { \"x\": 2108, \"y\": -1788, \"z\": 13 } ]'),
(9, 'Basurero LS', 'true', '[ { \"x\": 2441, \"y\": -2122, \"z\": 13 } ]'),
(10, 'Camionero LS', 'true', '[ { \"x\": 2183, \"y\": -2253, \"z\": 14 } ]');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `trabajosrangos`
--

CREATE TABLE `trabajosrangos` (
  `ID` int(11) NOT NULL,
  `Trabajo` varchar(255) NOT NULL,
  `Rango` int(11) NOT NULL,
  `Nombre` varchar(255) NOT NULL,
  `Salario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `trabajosrangos`
--

INSERT INTO `trabajosrangos` (`ID`, `Trabajo`, `Rango`, `Nombre`, `Salario`) VALUES
(1, 'Desempleado', 1, 'Desempleado', 50),
(27, 'ROSS Custom Garage', 1, 'Asistente', 50),
(28, 'ROSS Custom Garage', 2, 'Mecanico', 50),
(29, 'ROSS Custom Garage', 3, 'Ingeniero Mecánico', 50),
(30, 'ROSS Custom Garage', 4, 'Líder de Equipo', 50),
(31, 'Sanctuary Garage', 1, 'Mecanico Aprendiz', 1172),
(32, 'Sanctuary Garage', 2, 'Mecánico Oficial', 1407),
(33, 'Sanctuary Garage', 3, 'Mecánico Especialista', 1688),
(34, 'Sanctuary Garage', 4, 'Mecánico Profesional', 2025),
(35, 'GoldenWrench', 1, 'Aprendiz de Mecánico', 1172),
(36, 'GoldenWrench', 2, 'Mecánico Junior', 1407),
(37, 'GoldenWrench', 3, 'Mecánico', 1688),
(38, 'GoldenWrench', 4, 'Mecánico Senior', 2025),
(39, 'GoldenWrench', 5, 'Especialista en Grúa', 2431),
(40, 'Pizzero Idlewood', 1, 'Repartidor', 100),
(41, 'Sanctuary Garage', 5, 'Encargado', 2431),
(42, 'Sanctuary Garage', 6, 'Supervisores', 2917),
(43, 'Pizzero Idlewood', 2, 'Mesero', 100),
(45, 'ROSS Custom Garage', 5, 'Recepcionista', 50),
(46, 'ROSS Custom Garage', 6, 'Supervisor', 50),
(47, 'ROSS Custom Garage', 7, 'Director', 50),
(49, 'Los Santos Police Departament', 1, 'Cadete', 1012),
(50, 'Los Santos Police Departament', 2, 'Oficial I', 1215),
(51, 'Los Santos Police Departament', 3, 'Oficial II', 1458),
(52, 'Los Santos Police Departament', 4, 'Oficial III', 1750),
(53, 'Los Santos Police Departament', 5, 'Oficial III+', 2100),
(54, 'Los Santos Police Departament', 6, 'Sargento I', 2519),
(55, 'Los Santos Police Departament', 7, 'Sargento II', 3023),
(56, 'Los Santos Police Departament', 8, 'Teniente I', 3628),
(57, 'Los Santos Police Departament', 9, 'Teniente II', 4354),
(58, 'Los Santos Police Departament', 10, 'Capitán', 5224),
(59, 'Los Santos Police Departament', 11, 'Comandante de policia', 6269),
(60, 'Los Santos Police Departament', 12, 'Jefe adjunto', 7523),
(61, 'Los Santos Police Departament', 13, 'Jefe asistente', 9028),
(62, 'Los Santos Police Departament', 14, 'Jefe de policía', 10833),
(63, 'Los Santos Emergency Services', 1, 'Aprendiz', 1192),
(64, 'Los Santos Emergency Services', 2, 'Junior Paramedic', 1430),
(65, 'Los Santos Emergency Services', 3, 'Paramedic', 1716),
(66, 'Los Santos Emergency Services', 4, 'Senior Paramedic', 2059),
(67, 'Los Santos Emergency Services', 5, 'Teniente Junior', 2471),
(68, 'Los Santos Emergency Services', 6, 'Teniente', 2965),
(69, 'Los Santos Emergency Services', 7, 'Capitan Junior', 3558),
(70, 'Los Santos Emergency Services', 8, 'Capitan', 4270),
(71, 'Los Santos Emergency Services', 9, 'Battalion Chief', 5124),
(72, 'Los Santos Emergency Services', 10, 'Supervisor', 6149),
(73, 'Los Santos Emergency Services', 11, 'Supervisor en jefe', 7378),
(74, 'Los Santos Emergency Services', 12, 'Jefe de división', 8854),
(75, 'Los Santos Emergency Services', 13, 'Sub Chief', 10625),
(76, 'Los Santos Emergency Services', 14, 'EMS Chief', 12750),
(77, 'Los Santos Justice Department', 1, 'Estudiante', 2000),
(78, 'Los Santos Justice Department', 2, 'Asistente Legal', 2400),
(79, 'Los Santos Justice Department', 3, 'Abogado Junior', 2880),
(80, 'Los Santos Justice Department', 4, 'Abogado Asociado', 3456),
(81, 'Los Santos Justice Department', 5, 'Fiscal Adjunto', 4147),
(82, 'Los Santos Justice Department', 6, 'Fiscal de Distrito', 4977),
(83, 'Los Santos Justice Department', 7, 'Juez de Paz', 5972),
(84, 'Los Santos Justice Department', 8, 'Juez Estatal', 7166),
(85, 'Los Santos Justice Department', 9, 'Juez Federal', 8589),
(86, 'Los Santos Justice Department', 10, 'Fiscal General', 10306),
(87, 'Los Santos Justice Department', 11, 'Juez de Apelaciones', 12367),
(88, 'Los Santos Justice Department', 12, 'Juez Presidente', 14840),
(89, 'Los Santos Justice Department', 13, 'Juez del Tribunal Supremo Estatal', 17808),
(90, 'Los Santos Justice Department', 14, 'Juez del Tribunal Supremo del estado', 21369),
(91, 'GoldenWrench', 6, 'Jefe de Taller', 2917),
(92, 'GoldenWrench', 7, 'Dueño del Taller', 3500),
(93, 'Basurero LS', 1, 'Recolector', 100),
(94, 'Basurero LS', 2, 'Recolector Maestro', 100),
(95, 'Sanctuary Garage', 7, 'Jefe', 3500);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `trabajosusers`
--

CREATE TABLE `trabajosusers` (
  `ID` int(11) NOT NULL,
  `Personajes` varchar(255) NOT NULL,
  `Trabajo` varchar(255) NOT NULL,
  `Rango` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `userstop`
--

CREATE TABLE `userstop` (
  `ID` int(11) NOT NULL,
  `Fecha` date NOT NULL,
  `MaximoJugadores` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vehiculosconcesionario`
--

CREATE TABLE `vehiculosconcesionario` (
  `ID` int(11) NOT NULL,
  `NOMBRE` varchar(255) NOT NULL,
  `MODELO` int(11) NOT NULL,
  `PRECIO` int(11) NOT NULL,
  `CATEGORIA` varchar(255) NOT NULL,
  `STOCK` int(11) NOT NULL,
  `SLOTS` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `vehiculosconcesionario`
--

INSERT INTO `vehiculosconcesionario` (`ID`, `NOMBRE`, `MODELO`, `PRECIO`, `CATEGORIA`, `STOCK`, `SLOTS`) VALUES
(1, 'StuntPlane', 513, 10000000, 'Voladores', 25, 20),
(2, 'Dodo', 593, 10000000, 'Voladores', 25, 20),
(3, 'Sparrow', 469, 10000000, 'Voladores', 25, 20),
(4, 'Beagle', 511, 10000000, 'Voladores', 25, 20),
(5, 'Shamal', 519, 10000000, 'Voladores', 25, 20),
(6, 'Dinghy', 473, 10000000, 'Boats', 75, 5),
(7, 'Maverick', 487, 10000000, 'Voladores', 25, 20),
(8, 'Nevada', 553, 10000000, 'Voladores', 25, 20),
(9, 'Coastguard', 472, 10000000, 'Boats', 75, 5),
(10, 'Speeder', 452, 10000000, 'Boats', 75, 5),
(11, 'Marquis', 484, 10000000, 'Boats', 75, 5),
(12, 'Reefer', 453, 10000000, 'Boats', 75, 5),
(13, 'Jetmax', 493, 10000000, 'Boats', 75, 5),
(14, 'Squalo', 446, 10000000, 'Boats', 75, 5),
(15, 'Tropic', 454, 10000000, 'Boats', 75, 5),
(16, 'Skimmer', 460, 10000000, 'Boats', 75, 20),
(17, 'Bike', 509, 100, 'Bike', 1000, 0),
(18, 'BMX', 481, 100, 'Bike', 997, 0),
(19, 'Mountain Bike', 510, 100, 'Bike', 999, 0),
(20, 'Faggio', 462, 6450, 'Motorbike', 49, 1),
(21, 'Quadbike', 471, 17199, 'Motorbike', 61, 1),
(22, 'Sanchez', 468, 47298, 'Motorbike', 92, 1),
(23, 'Wayfarer', 586, 51598, 'Motorbike', 100, 1),
(24, 'Freeway', 463, 55898, 'Motorbike', 99, 1),
(25, 'BF-400', 581, 167693, 'Motorbike', 100, 1),
(26, 'PCJ-600', 461, 251539, 'Motorbike', 100, 1),
(27, 'FCR-900', 521, 257989, 'Motorbike', 100, 1),
(28, 'NRG-500', 522, 498779, 'Motorbike', 99, 1),
(29, 'Manana', 410, 25799, 'Baja', 168, 10),
(30, 'Perennial', 404, 30099, 'Baja', 193, 14),
(31, 'Regina', 479, 34399, 'Baja', 200, 14),
(32, 'Oceanic', 467, 38698, 'Baja', 198, 12),
(33, 'Greenwood', 492, 42998, 'Baja', 196, 12),
(34, 'Glendale', 466, 60197, 'Baja', 200, 12),
(35, 'Hustler', 545, 64497, 'Baja', 200, 10),
(36, 'Bravura', 401, 68797, 'Baja', 200, 10),
(37, 'Hermes', 474, 73097, 'Baja', 200, 10),
(38, 'Virgo', 491, 77397, 'Baja', 200, 10),
(39, 'Cadrona', 527, 81697, 'Baja', 200, 10),
(40, 'Esperanto', 419, 85996, 'Baja', 200, 10),
(41, 'Previon', 436, 90296, 'Baja', 200, 10),
(42, 'Intruder', 546, 94596, 'Baja', 200, 12),
(43, 'Willard', 529, 98896, 'Baja', 200, 12),
(44, 'Vincent', 540, 103196, 'Baja', 199, 12),
(45, 'Picador', 600, 107495, 'Baja', 200, 10),
(46, 'Stafford', 580, 174143, 'Baja', 200, 12),
(47, 'Tampa', 549, 180592, 'Baja', 200, 10),
(48, 'Uranus', 558, 193492, 'Baja', 200, 8),
(49, 'Solair', 458, 199941, 'Baja', 200, 14),
(50, 'Broadway', 575, 206391, 'Baja', 200, 10),
(51, 'Tornado', 576, 212841, 'Baja', 200, 10),
(52, 'Majestic', 517, 219291, 'Baja', 200, 10),
(53, 'Nebula', 516, 225740, 'Baja', 200, 12),
(54, 'Fortune', 526, 232190, 'Baja', 200, 10),
(55, 'Merit', 551, 238640, 'Baja', 200, 12),
(56, 'Tahoma', 566, 245090, 'Baja', 200, 12),
(57, 'Blista Compact', 496, 264439, 'Baja', 200, 10),
(58, 'Clover', 542, 283788, 'Baja', 200, 8),
(59, 'Buccaneer', 518, 290238, 'Baja', 200, 10),
(60, 'Euros', 587, 296687, 'Baja', 200, 10),
(61, 'Voodoo', 412, 316037, 'Baja', 200, 10),
(62, 'Remington', 534, 322486, 'Baja', 200, 10),
(63, 'Alpha', 602, 328936, 'Baja', 200, 10),
(64, 'Camper', 483, 21499, 'Media', 85, 4),
(65, 'Blade', 536, 464380, 'Baja', 200, 10),
(66, 'Rancher', 489, 34399, 'Media', 95, 14),
(67, 'Savanna', 567, 472980, 'Baja', 200, 10),
(68, 'Mesa', 500, 38698, 'Media', 98, 4),
(69, 'Primo', 547, 47298, 'Media', 99, 12),
(70, 'Sunrise', 550, 55898, 'Media', 95, 12),
(71, 'Emperor', 585, 174143, 'Media', 100, 12),
(72, 'Washington', 421, 180592, 'Media', 99, 12),
(73, 'Stratum', 561, 187042, 'Media', 99, 8),
(74, 'Windsor', 555, 199941, 'Media', 100, 8),
(75, 'Slamvan', 535, 206391, 'Media', 99, 10),
(76, 'Landstalker', 400, 212841, 'Media', 100, 14),
(77, 'Huntley', 579, 219291, 'Media', 98, 14),
(78, 'Club', 589, 264439, 'Media', 100, 10),
(79, 'Admiral', 445, 270888, 'Media', 100, 12),
(80, 'Sentinel', 405, 277338, 'Media', 100, 12),
(81, 'Flash', 565, 283788, 'Media', 96, 8),
(82, 'Elegant', 507, 303137, 'Media', 99, 12),
(83, 'Feltzer', 533, 309587, 'Media', 100, 10),
(84, 'Stallion', 439, 316037, 'Media', 100, 10),
(85, 'Sultan', 560, 447181, 'Media', 90, 8),
(86, 'Sabre', 475, 464380, 'Media', 100, 4),
(87, 'Premier', 426, 481579, 'Media', 100, 12),
(88, 'Sandking', 495, 490179, 'Media', 100, 4),
(89, 'Jester', 559, 507378, 'Media', 98, 8),
(90, 'Elegy', 562, 515978, 'Media', 81, 8),
(91, 'Comet', 480, 533177, 'Media', 97, 8),
(92, 'Phoenix', 603, 455781, 'Alta', 50, 8),
(93, 'Super GT', 506, 524578, 'Alta', 47, 8),
(94, 'Buffalo', 402, 541777, 'Alta', 49, 8),
(95, 'ZR-350', 477, 550377, 'Alta', 50, 8),
(96, 'Cheetah', 415, 698720, 'Alta', 50, 8),
(97, 'Turismo', 451, 709470, 'Alta', 44, 8),
(98, 'Banshee', 429, 720219, 'Alta', 50, 8),
(99, 'Bullet', 541, 730969, 'Alta', 48, 8),
(100, 'Infernus', 411, 741718, 'Alta', 37, 8),
(101, 'Journey', 508, 902962, 'Alta', 5, 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vehiculosusuarios`
--

CREATE TABLE `vehiculosusuarios` (
  `ID` int(11) NOT NULL,
  `IDPersonaje` int(11) NOT NULL,
  `INFORMACION` varchar(500) NOT NULL DEFAULT '',
  `ESTADO` varchar(500) NOT NULL DEFAULT '',
  `UBICACION` varchar(500) NOT NULL DEFAULT '0',
  `TUNNING` varchar(500) NOT NULL DEFAULT '',
  `INVENTARIO` varchar(10000) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `weaponplayer`
--

CREATE TABLE `weaponplayer` (
  `Usuario` int(11) NOT NULL,
  `Weapons` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cajeros`
--
ALTER TABLE `cajeros`
  ADD PRIMARY KEY (`ID`);

--
-- Indices de la tabla `cuentas`
--
ALTER TABLE `cuentas`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `Usuario` (`Usuario`);

--
-- Indices de la tabla `familias`
--
ALTER TABLE `familias`
  ADD PRIMARY KEY (`ID`) USING BTREE;

--
-- Indices de la tabla `familiasinteriores`
--
ALTER TABLE `familiasinteriores`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indices de la tabla `familiasrangos`
--
ALTER TABLE `familiasrangos`
  ADD PRIMARY KEY (`ID`);

--
-- Indices de la tabla `familiasusers`
--
ALTER TABLE `familiasusers`
  ADD PRIMARY KEY (`ID`) USING BTREE;

--
-- Indices de la tabla `familiasvehiculos`
--
ALTER TABLE `familiasvehiculos`
  ADD PRIMARY KEY (`ID`) USING BTREE,
  ADD UNIQUE KEY `ID` (`ID`) USING BTREE;

--
-- Indices de la tabla `interiores`
--
ALTER TABLE `interiores`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `jailicdisconnect`
--
ALTER TABLE `jailicdisconnect`
  ADD PRIMARY KEY (`ID`);

--
-- Indices de la tabla `jailoocdisconnect`
--
ALTER TABLE `jailoocdisconnect`
  ADD PRIMARY KEY (`ID`);

--
-- Indices de la tabla `jailoochistory`
--
ALTER TABLE `jailoochistory`
  ADD PRIMARY KEY (`ID`);

--
-- Indices de la tabla `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`ID`) USING BTREE;

--
-- Indices de la tabla `jobsrangos`
--
ALTER TABLE `jobsrangos`
  ADD PRIMARY KEY (`ID`) USING BTREE;

--
-- Indices de la tabla `jobsusers`
--
ALTER TABLE `jobsusers`
  ADD PRIMARY KEY (`ID`) USING BTREE;

--
-- Indices de la tabla `licencias`
--
ALTER TABLE `licencias`
  ADD PRIMARY KEY (`ID`);

--
-- Indices de la tabla `multasic`
--
ALTER TABLE `multasic`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `ID` (`ID`);

--
-- Indices de la tabla `npcrobos`
--
ALTER TABLE `npcrobos`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indices de la tabla `personajes`
--
ALTER TABLE `personajes`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `Nombre` (`Nombre`);

--
-- Indices de la tabla `propiedades`
--
ALTER TABLE `propiedades`
  ADD PRIMARY KEY (`ID`);

--
-- Indices de la tabla `rangos`
--
ALTER TABLE `rangos`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `Rango` (`Rango`),
  ADD UNIQUE KEY `Abreviatura` (`Abreviatura`);

--
-- Indices de la tabla `telefonos`
--
ALTER TABLE `telefonos`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `Telefono` (`Telefono`);

--
-- Indices de la tabla `trabajos`
--
ALTER TABLE `trabajos`
  ADD PRIMARY KEY (`ID`);

--
-- Indices de la tabla `trabajosrangos`
--
ALTER TABLE `trabajosrangos`
  ADD PRIMARY KEY (`ID`);

--
-- Indices de la tabla `trabajosusers`
--
ALTER TABLE `trabajosusers`
  ADD PRIMARY KEY (`ID`);

--
-- Indices de la tabla `userstop`
--
ALTER TABLE `userstop`
  ADD PRIMARY KEY (`ID`);

--
-- Indices de la tabla `vehiculosconcesionario`
--
ALTER TABLE `vehiculosconcesionario`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `ID` (`ID`);

--
-- Indices de la tabla `vehiculosusuarios`
--
ALTER TABLE `vehiculosusuarios`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `ID` (`ID`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `cajeros`
--
ALTER TABLE `cajeros`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT de la tabla `cuentas`
--
ALTER TABLE `cuentas`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `familias`
--
ALTER TABLE `familias`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de la tabla `familiasinteriores`
--
ALTER TABLE `familiasinteriores`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT de la tabla `familiasrangos`
--
ALTER TABLE `familiasrangos`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=122;

--
-- AUTO_INCREMENT de la tabla `familiasusers`
--
ALTER TABLE `familiasusers`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `familiasvehiculos`
--
ALTER TABLE `familiasvehiculos`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT de la tabla `interiores`
--
ALTER TABLE `interiores`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT de la tabla `jailicdisconnect`
--
ALTER TABLE `jailicdisconnect`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `jailoocdisconnect`
--
ALTER TABLE `jailoocdisconnect`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `jailoochistory`
--
ALTER TABLE `jailoochistory`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `jobs`
--
ALTER TABLE `jobs`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `jobsrangos`
--
ALTER TABLE `jobsrangos`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT de la tabla `jobsusers`
--
ALTER TABLE `jobsusers`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `licencias`
--
ALTER TABLE `licencias`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `multasic`
--
ALTER TABLE `multasic`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `npcrobos`
--
ALTER TABLE `npcrobos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=145;

--
-- AUTO_INCREMENT de la tabla `personajes`
--
ALTER TABLE `personajes`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `propiedades`
--
ALTER TABLE `propiedades`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `rangos`
--
ALTER TABLE `rangos`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT de la tabla `telefonos`
--
ALTER TABLE `telefonos`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `trabajos`
--
ALTER TABLE `trabajos`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `trabajosrangos`
--
ALTER TABLE `trabajosrangos`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=96;

--
-- AUTO_INCREMENT de la tabla `trabajosusers`
--
ALTER TABLE `trabajosusers`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `userstop`
--
ALTER TABLE `userstop`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `vehiculosconcesionario`
--
ALTER TABLE `vehiculosconcesionario`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=103;

--
-- AUTO_INCREMENT de la tabla `vehiculosusuarios`
--
ALTER TABLE `vehiculosusuarios`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
