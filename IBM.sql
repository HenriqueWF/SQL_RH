-- Selecionar toda a tabela (não coloquei LIMIT pois a tabela é pequena, com 1470 linhas)
SELECT 
    *
FROM IBM_HR_Analytics;

-- Verificar departamentos e quantidade de funcionários por setor
SELECT
	Department AS 'Departamento',
	COUNT(1) AS 'Total_Funcionarios'
FROM IBM_HR_Analytics
GROUP BY Department
ORDER BY Total_Funcionarios DESC

-- Analisar taxa de atrito
SELECT 
    Department AS 'Departamento',
    COUNT(*) AS 'Total_Funcionarios',
	SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS 'Funcionarios_Atrito',
    CONCAT(FORMAT((SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 'N2'), '%') AS 'Taxa_Atrito'
FROM IBM_HR_Analytics
GROUP BY Department
ORDER BY Taxa_Atrito DESC

-- Média de satisfação por departamento Attrition = 'No'
SELECT 
    Department AS Departamento,
    ROUND(AVG(JobSatisfaction), 2) AS 'Media_Satisfacao_Trabalho',
    ROUND(AVG(EnvironmentSatisfaction), 2) AS 'Media_Satisfacao_Ambiente',
    ROUND(AVG(RelationshipSatisfaction), 2) AS 'Media_Satisfacao_Relacionamento'
FROM IBM_HR_Analytics
WHERE Attrition = 'No'
GROUP BY Department
ORDER BY Departamento;

-- Média de satisfação por departamento Attrition = 'Yes'
SELECT 
    Department AS Departamento,
    ROUND(AVG(JobSatisfaction), 2) AS 'Media_Satisfacao_Trabalho',
    ROUND(AVG(EnvironmentSatisfaction), 2) AS 'Media_Satisfacao_Ambiente',
    ROUND(AVG(RelationshipSatisfaction), 2) AS 'Media_Satisfacao_Relacionamento'
FROM IBM_HR_Analytics
WHERE Attrition = 'Yes'
GROUP BY Department
ORDER BY Departamento;


-- Verificar Salários Attrition = 'No'
SELECT 
    Department AS 'Departamento',
    ROUND(AVG(MonthlyIncome), 2) AS 'Media_Salarial',
	MAX(MonthlyIncome) AS 'Maior_Salario',
	MIN(MonthlyIncome) AS 'Menor_Salario'
FROM 
    IBM_HR_Analytics
WHERE Attrition = 'No'
GROUP BY Department
ORDER BY Media_Salarial DESC;

-- Verificar Salários Attrition = 'Yes'
SELECT 
    Department AS 'Departamento',
    ROUND(AVG(MonthlyIncome), 2) AS 'Media_Salarial',
	MAX(MonthlyIncome) AS 'Maior_Salario',
	MIN(MonthlyIncome) AS 'Menor_Salario'
FROM 
    IBM_HR_Analytics
WHERE Attrition = 'Yes'
GROUP BY Department
ORDER BY Media_Salarial DESC;

-- PercentSalaryHike Attrition = 'Yes'
SELECT 
    'Funcionários que saíram' AS 'Grupo',
    ROUND(AVG(PercentSalaryHike), 2) AS 'Média_Aumento_Salarial',
    MIN(PercentSalaryHike) AS 'Menor_Aumento_Salarial',
    MAX(PercentSalaryHike) AS 'Maior_Aumento_Salarial'
FROM IBM_HR_Analytics
WHERE Attrition = 'Yes'

UNION ALL

-- PercentSalaryHike Attrition = 'No'
SELECT 
    'Funcionários que permaneceram' AS 'Grupo',
    ROUND(AVG(PercentSalaryHike), 2) AS 'Média_Aumento_Salarial',
    MIN(PercentSalaryHike) AS 'Menor_Aumento_Salarial',
    MAX(PercentSalaryHike) AS 'Maior_Aumento_Salarial'
FROM IBM_HR_Analytics
WHERE Attrition = 'No'; -- WHERE Attrition = 'Yes'; 

-- Horas Extras Attrition = 'Yes'
SELECT 
    Department AS 'Departamento',
    OverTime AS 'Horas_Extras',
    COUNT(*) AS 'Total_Funcionarios',
    FORMAT((COUNT(*) * 100.0) / SUM(COUNT(*)) OVER (PARTITION BY Department), 'N2') + '%' AS 'Percentual_Funcionarios_Departamento'
FROM 
    IBM_HR_Analytics
WHERE Attrition = 'Yes'
GROUP BY Department, OverTime
ORDER BY Department;

-- Horas Extras Attrition = 'No'
SELECT 
    Department AS 'Departamento',
    OverTime AS 'Horas_Extras',
    COUNT(*) AS 'Total_Funcionarios',
    FORMAT((COUNT(*) * 100.0) / SUM(COUNT(*)) OVER (PARTITION BY Department), 'N2') + '%' AS 'Percentual_Funcionarios_Departamento'
FROM 
    IBM_HR_Analytics
WHERE Attrition = 'No'
GROUP BY Department, OverTime
ORDER BY Department;

-- Verificar departamentos e quantidade de funcionários por setor
SELECT
	Department AS 'Departamento',
	JobRole AS 'Cargo',
	JobLevel,
	COUNT(1) AS 'Total_Funcionarios',
	SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS 'Funcionarios_Atrito',
    CONCAT(FORMAT((SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 'N2'), '%') AS 'Taxa_Atrito'
FROM IBM_HR_Analytics
GROUP BY Department, JobRole, JobLevel
ORDER BY Department, JobRole, JobLevel

-- Análise por departamento da variável 'JobInvolvement'
SELECT 
	Department AS 'Departamento',
	JobInvolvement,
	FORMAT(COUNT(*) * 1.0 / SUM(COUNT(*)) OVER(PARTITION BY Department), '0.00%') AS '%_Envolvimento',
	COUNT(*) AS 'Total_Funcionarios',
	SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS 'Funcionarios_Atrito',
	CONCAT(FORMAT((SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 'N2'), '%') AS 'Taxa_Atrito'
FROM IBM_HR_Analytics
GROUP BY Department, JobInvolvement
ORDER BY Department, JobInvolvement;

-- Análise de Gênero
SELECT 
    Gender AS 'Genero',
    COUNT(*) AS 'Total_Funcionarios',
	SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS 'Funcionarios_Atrito',
    CONCAT(FORMAT((SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 'N2'), '%') AS 'Taxa_Atrito'
FROM IBM_HR_Analytics
GROUP BY Gender
ORDER BY Taxa_Atrito DESC

-- Análise de Idade
SELECT
	MIN(Age) 'Idade Mínima',
	MAX(Age) 'Idade Máxima',
	ROUND(AVG(Age), 0) 'Média'
FROM
	IBM_HR_Analytics

-- Taxa de atrito por faixa etária
SELECT 
    Faixa_Etaria,
    COUNT(*) AS 'Total_Funcionarios',
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS 'Funcionarios_Atrito',
    CONCAT(FORMAT((SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 'N2'), '%') AS 'Taxa_Atrito'
FROM (
    SELECT 
        CASE 
            WHEN Age BETWEEN 18 AND 29 THEN '18-29'
            WHEN Age BETWEEN 30 AND 39 THEN '30-39'
            WHEN Age BETWEEN 40 AND 49 THEN '40-49'
            WHEN Age BETWEEN 50 AND 59 THEN '50-59'
            ELSE '60+'
        END AS 'Faixa_Etaria',
        Age,
        Attrition
    FROM 
        IBM_HR_Analytics
) AS Subquery
GROUP BY Faixa_Etaria
ORDER BY Faixa_Etaria;

-- Atrito entre Estado Civil e Viagens
SELECT 
    BusinessTravel,
    MaritalStatus,
    COUNT(*) AS 'Total_Funcionarios',
	SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS 'Funcionarios_Atrito',
    CONCAT(FORMAT((SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 'N2'), '%') AS 'Taxa_Atrito'
FROM IBM_HR_Analytics
GROUP BY BusinessTravel, MaritalStatus
ORDER BY BusinessTravel, MaritalStatus;

-- Verificar Distâncias de Casa e Taxa de Atrito
SELECT 
    Distancia,
    COUNT(*) AS 'Total_Funcionarios',
	SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS 'Funcionarios_Atrito',
    CONCAT(FORMAT((SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 'N2'), '%') AS 'Taxa_Atrito'
FROM (
	SELECT
		CASE
			WHEN DistanceFromHome BETWEEN 1 AND 5 THEN '1-5'
			WHEN DistanceFromHome BETWEEN 6 AND 10 THEN '6-10'
			WHEN DistanceFromHome BETWEEN 11 AND 15 THEN '11-15'
			WHEN DistanceFromHome BETWEEN 16 AND 20 THEN '16-20'
			WHEN DistanceFromHome BETWEEN 21 AND 25 THEN '21-25'
			WHEN DistanceFromHome BETWEEN 26 AND 29 THEN '26-29'
		END AS 'Distancia',
		DistanceFromHome,
		Attrition
	FROM IBM_HR_Analytics
) AS Subquery
GROUP BY Distancia
ORDER BY CAST(SUBSTRING(Distancia, 1, CHARINDEX('-', Distancia) - 1) AS INT);

-- Análise da Educação

-- Tabela para Educação
CREATE TABLE Education (
    EducationLevel INT PRIMARY KEY,
    EducationDescription VARCHAR(50)
);

INSERT INTO Education (EducationLevel, EducationDescription)
VALUES
    (1, 'Below College'),
    (2, 'College'),
    (3, 'Bachelor'),
    (4, 'Master'),
    (5, 'Doctor');

SELECT * FROM Education

-- Consulta Educação
SELECT 
    E.EducationDescription AS 'Educacao',
    COUNT(*) AS 'Total_Funcionarios',
	ROUND(AVG(MonthlyIncome), 2) AS 'Media_Salarial',
	SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS 'Funcionarios_Atrito',
    CONCAT(FORMAT((SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 'N2'), '%') AS 'Taxa_Atrito'
FROM IBM_HR_Analytics AS HR
INNER JOIN Education AS E 
	ON HR.Education = E.EducationLevel
GROUP BY E.EducationDescription, E.EducationLevel
ORDER BY E.EducationLevel;

-- Taxa de Atrito relacionado ao nº de treinamentos
SELECT  
	TrainingTimesLastYear, 
	COUNT(*) AS 'Total_Funcionarios',
	SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS 'Funcionarios_Atrito',
    CONCAT(FORMAT((SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 'N2'), '%') AS 'Taxa_Atrito'
FROM IBM_HR_Analytics
GROUP BY TrainingTimesLastYear
ORDER BY TrainingTimesLastYear

-- Taxa de Atrito Relacionado aos Anos de Empresa
SELECT 
    AnosNaEmpresa,
    COUNT(*) AS 'Total_Funcionarios',
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS 'Funcionarios_Atrito',
    CONCAT(FORMAT((SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 'N2'), '%') AS 'Taxa_Atrito'
FROM (
    SELECT
        CASE
            WHEN YearsAtCompany BETWEEN 0 AND 5 THEN '00-05'
            WHEN YearsAtCompany BETWEEN 6 AND 10 THEN '06-10'
            WHEN YearsAtCompany BETWEEN 11 AND 15 THEN '11-15'
            WHEN YearsAtCompany BETWEEN 16 AND 20 THEN '16-20'
            WHEN YearsAtCompany BETWEEN 21 AND 25 THEN '21-25'
            WHEN YearsAtCompany BETWEEN 26 AND 30 THEN '26-30'
            WHEN YearsAtCompany BETWEEN 31 AND 35 THEN '31-35'
            WHEN YearsAtCompany >= 36 THEN '36+'
        END AS 'AnosNaEmpresa',
        YearsAtCompany,
        Attrition
    FROM IBM_HR_Analytics
) AS Subquery
GROUP BY AnosNaEmpresa
ORDER BY CAST(SUBSTRING(AnosNaEmpresa, 1, 2) AS INT);

-- Taxa de Atrito relacionado aos anos desempenhando mesmo cargo
SELECT 
	YearsInCurrentRole,
	COUNT(*) AS 'Total_Funcionarios',
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS 'Funcionarios_Atrito',
    CONCAT(FORMAT((SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 'N2'), '%') AS 'Taxa_Atrito'
FROM IBM_HR_Analytics
GROUP BY YearsInCurrentRole
ORDER BY YearsInCurrentRole

-- Taxa de Atrito relacionado ao último ano que obteve promoção
SELECT  
	YearsSinceLastPromotion	,
	COUNT(*) AS 'Total_Funcionarios',
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS 'Funcionarios_Atrito',
    CONCAT(FORMAT((SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 'N2'), '%') AS 'Taxa_Atrito'
FROM IBM_HR_Analytics
GROUP BY YearsSinceLastPromotion	
ORDER BY YearsSinceLastPromotion	

-- WorkLifeBalance
SELECT
	--Department AS 'Departamento',
	WorkLifeBalance,
	COUNT(*) AS 'Total_Funcionarios',
	FORMAT((COUNT(*) * 100.0) / SUM(COUNT(*)) OVER (), 'N2') + '%' AS 'Percentual_Funcionarios_Por_Nivel',
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS 'Funcionarios_Atrito',
    CONCAT(FORMAT((SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 'N2'), '%') AS 'Taxa_Atrito'
FROM IBM_HR_Analytics
GROUP BY WorkLifeBalance --Department, 	
ORDER BY WorkLifeBalance --Department, 




