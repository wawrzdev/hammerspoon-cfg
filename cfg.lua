local cfg = {}
cfg.global = {}

local ufile = require('Utility.file')

local MONOFONT = 'Fira Mono'


cfg.global.paths = {}
cfg.global.paths.base  = os.getenv('HOME')
cfg.global.paths.tmp   = os.getenv('TMPDIR')
cfg.global.paths.bin   = ufile.toPath(cfg.global.paths.base, 'bin')
cfg.global.paths.hs    = ufile.toPath(cfg.global.paths.base, '.hammerspoon')
cfg.global.paths.resources = ufile.toPath(cfg.global.paths.hs,   'Resources')
cfg.global.paths.ul    = '/usr/local'
cfg.global.paths.ulbin = ufile.toPath(cfg.global.paths.ul,   'bin')

-------------
-- battery -- 
-------------
cfg.battery = {
    icon = ufile.toPath(cfg.global.paths.resources, 'battery.png')
}

--------------
-- caffeine --
-------------- 
cfg.caffeine = {
    menupriority = 1000,
    icons = {
        on = ufile.toPath(cfg.global.paths.resources, 'caffeine-on.pdf'),
        off = ufile.toPath(cfg.global.paths.resources, 'caffeine-off.pdf'),
    },
}

----------
-- grid --
----------
cfg.grid = {
    gridSize = '3x2',
    gridMargin = '0x0',
}

-- -------------
-- -- scratch -- 

-- -------------
-- cfg.scratch = {

-- }

-- ------------
-- -- spaces --
-- ------------
-- cfg.spaces = {

-- }

-- -----------
-- -- timer --
-- -----------
-- cfg.timer = {

-- }

-- -------------
-- -- weather --
-- -------------
-- cfg.weather = {

-- }

-- ----------
-- -- jira --
-- ----------
-- cfg.jira = {

-- }


-- ------------
-- -- gitlab --
-- ------------
-- cfg.gitlab = {

-- }

return cfg