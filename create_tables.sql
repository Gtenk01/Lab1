-- 1. Создание главной таблицы "Персонажи" (без SERIAL)
CREATE TABLE characters (
    character_id INT NOT NULL,                          -- код персонажа (теперь обычный INT)
    user_id INT NOT NULL,                               -- код пользователя
    character_name VARCHAR(100) NOT NULL,               -- имя персонажа
    character_story TEXT,                               -- история персонажа
    character_level INT NOT NULL DEFAULT 1,             -- уровень персонажа
    special_skills TEXT,                                -- особые умения персонажа
    
    -- Составной первичный ключ главной таблицы
    PRIMARY KEY (character_id, user_id)
);

-- 2. Создание зависимой таблицы "Итоги раундов" (с ПК из 3 элементов)
CREATE TABLE round_results (
    character_id INT NOT NULL,                          -- код персонажа
    round_id INT NOT NULL,                              -- код раунда
    user_id INT NOT NULL,                               -- код пользователя
    xp_earned INT NOT NULL DEFAULT 0,                   -- полученные очки опыта
    team_rating INT,                                    -- рейтинг в команде
    strikes_count INT NOT NULL DEFAULT 0,               -- количество страйков
    round_time INTERVAL NOT NULL,                       -- время в раунде
    is_team_winner BOOLEAN NOT NULL,                    -- команда победила
    is_disconnected BOOLEAN NOT NULL DEFAULT FALSE,     -- отключение во время раунда

    PRIMARY KEY (character_id, round_id, user_id),
    
    FOREIGN KEY (character_id, user_id) REFERENCES characters(character_id, user_id) 
        ON UPDATE CASCADE 
        ON DELETE CASCADE
);
