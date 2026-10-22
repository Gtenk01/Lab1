-- 1. Создание главной таблицы "Персонажи"
CREATE TABLE characters (
    character_id SERIAL PRIMARY KEY,                    -- код персонажа (автоинкремент)
    user_id INT NOT NULL,                               -- код пользователя
    character_name VARCHAR(100) NOT NULL,               -- имя персонажа
    character_story TEXT,                               -- история персонажа (может быть пустой)
    character_level INT NOT NULL DEFAULT 1,             -- уровень персонажа
    special_skills TEXT                                 -- особые умения персонажа
);

-- 2. Создание зависимой таблицы "Итоги раундов"
CREATE TABLE round_results (
    character_id INT NOT NULL,                          -- код персонажа (внешний ключ)
    round_id INT NOT NULL,                              -- код раунда
    user_id INT NOT NULL,                               -- код пользователя
    xp_earned INT NOT NULL DEFAULT 0,                   -- полученные очки опыта
    team_rating INT,                                    -- рейтинг в команде
    strikes_count INT NOT NULL DEFAULT 0,               -- количество страйков
    round_time INTERVAL NOT NULL,                       -- время в раунде (тип интервала времени)
    is_team_winner BOOLEAN NOT NULL,                    -- команда победила (логический тип)
    is_disconnected BOOLEAN NOT NULL DEFAULT FALSE,     -- отключение во время раунда

    -- Составной первичный ключ (персонаж + раунд)
    PRIMARY KEY (character_id, round_id),
    
    -- Внешний ключ на главную таблицу с каскадным обновлением и удалением
    FOREIGN KEY (character_id) REFERENCES characters(character_id) 
        ON UPDATE CASCADE 
        ON DELETE CASCADE
);