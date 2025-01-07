-- Criar o banco de dados
CREATE DATABASE cap_questionarios;
USE cap_questionarios;

-- Tabela para usuários
CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela para questionários
CREATE TABLE questionarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    descricao TEXT,
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela para perguntas
CREATE TABLE perguntas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_questionario INT NOT NULL,
    texto TEXT NOT NULL,
    FOREIGN KEY (id_questionario) REFERENCES questionarios(id) ON DELETE CASCADE
);

-- Tabela para respostas
CREATE TABLE respostas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_pergunta INT NOT NULL,
    id_usuario INT NOT NULL,
    resposta TEXT,
    data_resposta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_pergunta) REFERENCES perguntas(id) ON DELETE CASCADE,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id) ON DELETE CASCADE
);

-- Tabela para sugestões semanais
CREATE TABLE sugestoes_semanais (
    id INT AUTO_INCREMENT PRIMARY KEY,
    mes VARCHAR(50) NOT NULL,
    semana INT NOT NULL,
    sugestao TEXT NOT NULL,
    referencia_biblica TEXT,
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela para os direcionamentos
CREATE TABLE direcionamentos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    semana INT NOT NULL,
    descricao TEXT NOT NULL,
    referencia_biblica TEXT,
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Inserir os questionários
INSERT INTO questionarios (titulo, descricao) VALUES
('Dons Espirituais', 'Questionário para avaliação de dons espirituais.'),
('Frutos do Espírito Santo', 'Questionário sobre os frutos do Espírito Santo.'),
('Disciplinas Espirituais', 'Questionário sobre disciplinas espirituais.'),
('Pilares da Igreja CAP', 'Questionário baseado nos pilares Missões, Ensino, Adoração e Discipulado.'),
('Níveis de Relacionamento', 'Questionário sobre os níveis de relacionamento com Jesus.');

-- Inserir perguntas para cada questionário
-- Exemplo: Perguntas do questionário "Dons Espirituais"
INSERT INTO perguntas (id_questionario, texto) VALUES
(1, 'Você sente um forte desejo de ajudar outras pessoas de forma prática?'),
(1, 'Você tem facilidade em ensinar ou explicar a Palavra de Deus?'),
(1, 'Você se sente motivado a liderar grupos ou iniciativas cristãs?');

-- Exemplo: Perguntas do questionário "Frutos do Espírito Santo"
INSERT INTO perguntas (id_questionario, texto) VALUES
(2, 'Você demonstra amor incondicional pelos outros?'),
(2, 'Você consegue manter a paz em situações difíceis?'),
(2, 'Você é conhecido por sua paciência com as pessoas ao seu redor?');

-- Exemplo: Perguntas do questionário "Disciplinas Espirituais"
INSERT INTO perguntas (id_questionario, texto) VALUES
(3, 'Você dedica tempo diariamente para a oração?'),
(3, 'Você tem o hábito de meditar na Palavra de Deus regularmente?'),
(3, 'Você pratica o jejum como forma de buscar a Deus?');

-- Exemplo: Perguntas do questionário "Pilares da Igreja CAP"
INSERT INTO perguntas (id_questionario, texto) VALUES
(4, 'Você participa ativamente de atividades missionárias?'),
(4, 'Você se esforça para aprender mais sobre a Palavra de Deus?'),
(4, 'Você tem momentos regulares de adoração a Deus em sua vida?');

-- Exemplo: Perguntas do questionário "Níveis de Relacionamento"
INSERT INTO perguntas (id_questionario, texto) VALUES
(5, 'Você se sente parte da multidão que segue Jesus de forma mais distante?'),
(5, 'Você se identifica como um dos 70 discípulos que receberam missões específicas de Jesus?'),
(5, 'Você tem um relacionamento íntimo com Jesus, semelhante ao dos 12 discípulos?');
