## **Requisitos Funcionais**

### **1\. Cadastro de Usuários**

*   O sistema deve permitir que os usuários se cadastrem com:
    *   Nome completo
    *   Email
    *   Senha
*   O sistema deve permitir o login seguro para acesso aos dados.

### **2\. Registro Diário de Dados**

O sistema deve permitir ao usuário registrar informações diárias relacionadas às premissas abaixo, cada um dos tópicos ja possui um questionário os quais dentro do sistema devem ser processados e retornar um valor para o usuário no dashboard de acordo com as respostas as questões informadas:

1.  **5 Ministérios Bíblicos**:
    *   Apostólico, Profético, Evangelístico, Pastoral e Ensino.
    *   O usuário deve registrar o grau de expressão de cada ministério em uma escala (ex.: 0 a 10).
2.  **Dons Espirituais**:
    *   Listar os dons espirituais (ex.: Sabedoria, Fé, Cura, Profecia, etc.).
    *   O usuário deve avaliar diariamente o grau de expressão de cada dom em uma escala (ex.: 0 a 10).
3.  **Frutos do Espírito Santo**:
    *   Listar os frutos (ex.: Amor, Alegria, Paz, Paciência, etc.).
    *   O usuário deve avaliar o grau de expressão de cada fruto em uma escala (ex.: 0 a 10).
4.  **Disciplinas Espirituais**:
    *   Permitir que o usuário registre quais disciplinas espirituais foram praticadas (ex.: Oração, Jejum, Estudo Bíblico, etc.).
    *   Opcional: Adicionar observações ou reflexões diárias.
5.  **Missão da Igreja Local**:
    *   Listar os itens da missão da igreja e permitir que o usuário indique quais está atendendo no dia.
6.  **Pilares da Igreja Local**:
    *   Listar os pilares e permitir que o usuário registre os atendidos.
7.  **Nível de Intimidade com Cristo**:
    *   Permitir que o usuário selecione diariamente o nível de intimidade percebido (Multidão, 70, 12, 3, 1).
8.  **Ano apostólico tema mensal com 3 subtemas para as 3 primeiras semanas**:
    *   Permitir sugestão semanal no app
9.  **Ano apostólico 4 direcionamentos (Evangelizar, Estabelecer na palavra, Fundamentar na palavra e Edificar ) com 3 subtemas para as 3 primeiras semanas**:
    *   Permitir sugestão semanal no app

### **3\. Processamento de Dados**

*   O sistema deve calcular:
    *   Uma pontuação geral diária baseada nos itens preenchidos.
    *   Um relatório semanal/mensal com gráficos e insights para ajudar o usuário a identificar áreas de crescimento.
    *   Recomendações práticas baseadas nos dados (ex.: "Aumente sua prática de oração para fortalecer o fruto da paciência.").
    *   Dentro do sistema devem ser processados e retornar um valor para o usuário no dashboard de acordo com as respostas as questões informadas dos questionários acima citados

### **4\. Planos de Crescimento Espiritual**

*   O sistema deve sugerir planos personalizados de crescimento espiritual com base nos dados do usuário.
*   Exemplos de planos:
    *   "Plano de fortalecimento dos frutos do Espírito."
    *   "Plano de maior engajamento nos pilares da igreja."
    *   "Plano de maior engajamento no Nível de Intimidade com Cristo."
    *   "Plano de maior engajamento nos Ano apostólico tema mensal."
    *   "Plano de maior engajamento no Ano apostólico 4 direcionamentos (Evangelizar, Estabelecer na palavra, Fundamentar na palavra e Edificar )."

### **5\. Histórico e Relatórios**

*   Permitir que o usuário veja:
    *   Um histórico diário/semanal/mensal das práticas.
    *   Gráficos de evolução de ministérios, dons, frutos e outros itens.

## **Requisitos Não Funcionais**

1.  **Interface Intuitiva**:
    *   O sistema deve ter uma interface amigável e acessível, com design adaptado para dispositivos móveis e desktops.
2.  **Segurança**:
    *   Proteger os dados do usuário com autenticação segura e criptografia.
3.  **Disponibilidade**:
    *   O sistema deve estar disponível 24/7.
4.  **Escalabilidade**:
    *   Suportar crescimento no número de usuários sem perda de desempenho.
5.  **Compatibilidade**:
    *   Funcionar em navegadores modernos e, opcionalmente, como aplicativo móvel.

## **Requisitos Técnicos**

1.  **Backend**:
    *   Framework: Flutter
    *   Banco de Dados: MySQL,
2.  **Frontend**:
    *   Framework: Flutter (se também for app móvel).
3.  **API**:
    *   Criar uma API para integração entre frontend e backend.
4.  **Sistema de Relatórios**:
    *   Bibliotecas para gráficos e relatórios: Chart.js
5.  **Padrão de Projetos**: MVC

## **Próximos Passos**

*   Detalhar as funcionalidades específicas em histórias de usuário.
*   Criar protótipos de interface.
*   Definir as tecnologias que serão utilizadas.