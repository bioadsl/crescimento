-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 15/01/2025 às 14:06
-- Versão do servidor: 10.4.32-MariaDB
-- Versão do PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `crescimento`
--

CREATE DATABASE crescimento;
USE crescimento;

-- --------------------------------------------------------

--
-- Estrutura para tabela `five_ministries_results`
--

CREATE TABLE `five_ministries_results` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `apostolic` int(11) NOT NULL,
  `prophetic` int(11) NOT NULL,
  `evangelistic` int(11) NOT NULL,
  `pastoral` int(11) NOT NULL,
  `teaching` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `five_ministries_results`
--

INSERT INTO `five_ministries_results` (`id`, `user_id`, `apostolic`, `prophetic`, `evangelistic`, `pastoral`, `teaching`, `created_at`) VALUES
(1, 1, 15, 15, 15, 20, 25, '2025-01-10 02:16:25'),
(2, 1, 15, 15, 15, 20, 25, '2025-01-10 13:45:47'),
(3, 1, 11, 23, 17, 23, 15, '2025-01-14 00:59:16');

-- --------------------------------------------------------

--
-- Estrutura para tabela `fruit_of_the_spirit_results`
--

CREATE TABLE `fruit_of_the_spirit_results` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `love` int(11) NOT NULL,
  `joy` int(11) NOT NULL,
  `peace` int(11) NOT NULL,
  `patience` int(11) NOT NULL,
  `kindness` int(11) NOT NULL,
  `goodness` int(11) NOT NULL,
  `faithfulness` int(11) NOT NULL,
  `gentleness` int(11) NOT NULL,
  `self_control` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `fruit_of_the_spirit_results`
--

INSERT INTO `fruit_of_the_spirit_results` (`id`, `user_id`, `love`, `joy`, `peace`, `patience`, `kindness`, `goodness`, `faithfulness`, `gentleness`, `self_control`, `created_at`) VALUES
(1, 1, 25, 25, 25, 20, 22, 22, 21, 19, 19, '2025-01-13 04:03:24');

-- --------------------------------------------------------

--
-- Estrutura para tabela `intimacy_level_results`
--

CREATE TABLE `intimacy_level_results` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `mission` int(11) NOT NULL,
  `sharing` int(11) NOT NULL,
  `prayer` int(11) NOT NULL,
  `bible` int(11) NOT NULL,
  `challenges` int(11) NOT NULL,
  `support` int(11) NOT NULL,
  `relationship` int(11) NOT NULL,
  `heart` int(11) NOT NULL,
  `total_score` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `intimacy_level_results`
--

INSERT INTO `intimacy_level_results` (`id`, `user_id`, `mission`, `sharing`, `prayer`, `bible`, `challenges`, `support`, `relationship`, `heart`, `total_score`, `created_at`) VALUES
(1, 1, 4, 2, 3, 3, 4, 4, 5, 5, 30, '2025-01-13 23:38:31');

-- --------------------------------------------------------

--
-- Estrutura para tabela `pillars_results`
--

CREATE TABLE `pillars_results` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `missions` int(11) NOT NULL,
  `teaching` int(11) NOT NULL,
  `discipleship` int(11) NOT NULL,
  `worship` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `spiritual_disciplines_results`
--

CREATE TABLE `spiritual_disciplines_results` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `prayer` int(11) NOT NULL,
  `bibleReading` int(11) NOT NULL,
  `fasting` int(11) NOT NULL,
  `meditation` int(11) NOT NULL,
  `worship` int(11) NOT NULL,
  `fellowship` int(11) NOT NULL,
  `service` int(11) NOT NULL,
  `silence` int(11) NOT NULL,
  `generosity` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `spiritual_gifts_results`
--

CREATE TABLE `spiritual_gifts_results` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `prophecy` int(11) NOT NULL,
  `discernment` int(11) NOT NULL,
  `tongues` int(11) NOT NULL,
  `interpretation` int(11) NOT NULL,
  `wisdom` int(11) NOT NULL,
  `knowledge` int(11) NOT NULL,
  `faith` int(11) NOT NULL,
  `healing` int(11) NOT NULL,
  `miracles` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `spiritual_gifts_results`
--

INSERT INTO `spiritual_gifts_results` (`id`, `user_id`, `prophecy`, `discernment`, `tongues`, `interpretation`, `wisdom`, `knowledge`, `faith`, `healing`, `miracles`, `created_at`) VALUES
(1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '2025-01-14 23:55:14'),
(2, 2, 3, 3, 4, 4, 2, 2, 1, 1, 5, '2025-01-15 01:06:55');

-- --------------------------------------------------------

--
-- Estrutura para tabela `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`) VALUES
(1, 'teste', 'teste@teste.com', 'teste');

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `five_ministries_results`
--
ALTER TABLE `five_ministries_results`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `fruit_of_the_spirit_results`
--
ALTER TABLE `fruit_of_the_spirit_results`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `intimacy_level_results`
--
ALTER TABLE `intimacy_level_results`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `pillars_results`
--
ALTER TABLE `pillars_results`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `spiritual_disciplines_results`
--
ALTER TABLE `spiritual_disciplines_results`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `spiritual_gifts_results`
--
ALTER TABLE `spiritual_gifts_results`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `five_ministries_results`
--
ALTER TABLE `five_ministries_results`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `fruit_of_the_spirit_results`
--
ALTER TABLE `fruit_of_the_spirit_results`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `intimacy_level_results`
--
ALTER TABLE `intimacy_level_results`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `pillars_results`
--
ALTER TABLE `pillars_results`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `spiritual_disciplines_results`
--
ALTER TABLE `spiritual_disciplines_results`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `spiritual_gifts_results`
--
ALTER TABLE `spiritual_gifts_results`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
