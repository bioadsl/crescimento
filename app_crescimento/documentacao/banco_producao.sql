-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 23-Fev-2025 às 16:40
-- Versão do servidor: 10.4.22-MariaDB
-- versão do PHP: 8.0.13

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

-- --------------------------------------------------------

--
-- Estrutura da tabela `five_ministries_results`
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- --------------------------------------------------------

--
-- Estrutura da tabela `fruit_of_the_spirit_results`
--

CREATE TABLE `fruit_of_the_spirit_results` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `love` int(11) DEFAULT NULL,
  `joy` int(11) DEFAULT NULL,
  `peace` int(11) DEFAULT NULL,
  `patience` int(11) DEFAULT NULL,
  `kindness` int(11) DEFAULT NULL,
  `goodness` int(11) DEFAULT NULL,
  `faithfulness` int(11) DEFAULT NULL,
  `gentleness` int(11) DEFAULT NULL,
  `self_control` int(11) DEFAULT NULL,
  `total_score` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- --------------------------------------------------------

--
-- Estrutura da tabela `intimacy_level_results`
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `intimacy_level_results`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `pillars_results`
--

CREATE TABLE `pillars_results` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `missions` int(11) NOT NULL,
  `teaching` int(11) NOT NULL,
  `discipleship` int(11) NOT NULL,
  `worship` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- --------------------------------------------------------

--
-- Estrutura da tabela `spiritual_disciplines_results`
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

- --------------------------------------------------------

--
-- Estrutura da tabela `spiritual_gifts_results`
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- --------------------------------------------------------

--
-- Estrutura da tabela `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `five_ministries_results`
--
ALTER TABLE `five_ministries_results`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `fruit_of_the_spirit_results`
--
ALTER TABLE `fruit_of_the_spirit_results`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `intimacy_level_results`
--
ALTER TABLE `intimacy_level_results`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `pillars_results`
--
ALTER TABLE `pillars_results`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `spiritual_disciplines_results`
--
ALTER TABLE `spiritual_disciplines_results`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `spiritual_gifts_results`
--
ALTER TABLE `spiritual_gifts_results`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `five_ministries_results`
--
ALTER TABLE `five_ministries_results`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=0;

--
-- AUTO_INCREMENT de tabela `fruit_of_the_spirit_results`
--
ALTER TABLE `fruit_of_the_spirit_results`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=0;

--
-- AUTO_INCREMENT de tabela `intimacy_level_results`
--
ALTER TABLE `intimacy_level_results`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=0;

--
-- AUTO_INCREMENT de tabela `pillars_results`
--
ALTER TABLE `pillars_results`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=0;

--
-- AUTO_INCREMENT de tabela `spiritual_disciplines_results`
--
ALTER TABLE `spiritual_disciplines_results`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=0;

--
-- AUTO_INCREMENT de tabela `spiritual_gifts_results`
--
ALTER TABLE `spiritual_gifts_results`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=0;

--
-- AUTO_INCREMENT de tabela `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=0;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
