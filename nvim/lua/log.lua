local Log = {}

local logfile = string.format("%s/%s.log", vim.fn.stdpath "cache", "logger")

Log.levels = {TRACE = 1, DEBUG = 2, INFO = 3, WARN = 4, ERROR = 5}

-- Fixed: vim.tbl_add_reverse_lookup is deprecated, manually create reverse lookup
-- Create reverse lookup: {1 = "TRACE", 2 = "DEBUG", ...}
for name, value in pairs(Log.levels) do
    Log.levels[value] = name
end

function Log:init()
    local status_ok, structlog = pcall(require, "structlog")
    if not status_ok then return nil end

    local nvim_notify_params = {}
    local nvim_notify_params_injecter = function(_, entry)
        for key, value in pairs(nvim_notify_params) do entry[key] = value end
        return entry
    end

    local nvim_notify_default_namer = function(logger, entry)
        entry["title"] = logger.name
        return entry
    end

    nvim_notify_params_injecter(nil, {})
    -- Fixed: lvim is not defined, use default log level "WARN" (4)
    -- If you want to configure log level, set it via a config variable
    local log_level_name = "WARN" -- Default log level
    local log_level = Log.levels[log_level_name] or Log.levels.WARN
    structlog.configure {
        nvim = {  -- Changed from "lvim" to "nvim" since lvim is not available
            sinks = {
                structlog.sinks.Console(log_level, {
                    async = false,
                    processors = {
                        structlog.processors.Namer(),
                        structlog.processors
                            .StackWriter({"line", "file"}, {max_parents = 0, stack_level = 2}),
                        structlog.processors.Timestamper "%H:%M:%S"
                    },
                    formatter = structlog.formatters.FormatColorizer( --
                    "%s [%-5s] %s: %-30s", {"timestamp", "level", "logger_name", "msg"},
                    {level = structlog.formatters.FormatColorizer.color_level()})
                }), structlog.sinks.NvimNotify(Log.levels.INFO, {
                    processors = {nvim_notify_default_namer, nvim_notify_params_injecter},
                    formatter = structlog.formatters.Format( --
                    "%s", {"msg"}, {blacklist_all = true}),
                    params_map = {
                        icon = "icon",
                        keep = "keep",
                        on_open = "on_open",
                        on_close = "on_close",
                        timeout = "timeout",
                        title = "title"
                    }
                }), structlog.sinks.File(Log.levels.TRACE, logfile, {
                    processors = {
                        structlog.processors.Namer(),
                        structlog.processors
                            .StackWriter({"line", "file"}, {max_parents = 3, stack_level = 2}),
                        structlog.processors.Timestamper "%H:%M:%S"
                    },
                    formatter = structlog.formatters.Format( --
                    "%s [%-5s] %s: %-30s", {"timestamp", "level", "logger_name", "msg"})
                })
            }
        }
    }

    local logger = structlog.get_logger "nvim"  -- Changed from "lvim" to "nvim"

    -- Fixed: lvim.log.override_notify is not defined, make it configurable
    -- Set this to true if you want to override vim.notify
    local override_notify = false  -- Set to true to enable notify override
    if override_notify then
        -- Store original vim.notify to avoid duplicate field warning
        local original_notify = vim.notify
        -- Overwrite vim.notify to use the logger
        vim.notify = function(msg, vim_log_level, opts)
            nvim_notify_params = opts or {}
            -- vim_log_level can be omitted
            if type(vim_log_level) == "string" then
                vim_log_level = Log.levels[(vim_log_level):upper() or "INFO"]
            end
            -- https://github.com/neovim/neovim/blob/685cf398130c61c158401b992a1893c2405cd7d2/runtime/lua/vim/lsp/log.lua#L5
            logger:log(vim_log_level + 1, msg)
        end
    end

    return logger
end

--- Adds a log entry using Plenary.log
---@param level number|string [log level as number (1-5) or string name]
---@param msg any
---@param event any
function Log:add_entry(level, msg, event)
    -- Fixed: Convert level to number if it's a string, or use directly if number
    local level_num = type(level) == "string" and Log.levels[level] or level
    if self.__handle then
        self.__handle:log(level_num, msg, event)
        return
    end

    local logger = self:init()
    if not logger then return end

    self.__handle = logger
    self.__handle:log(level_num, msg, event)
end

---Retrieves the path of the logfile
---@return string path of the logfile
function Log:get_path()
    return logfile
end

---Add a log entry at TRACE level
---@param msg any
---@param event any
function Log:trace(msg, event)
    self:add_entry(self.levels.TRACE, msg, event)
end

---Add a log entry at DEBUG level
---@param msg any
---@param event any
function Log:debug(msg, event)
    self:add_entry(self.levels.DEBUG, msg, event)
end

---Add a log entry at INFO level
---@param msg any
---@param event any
function Log:info(msg, event)
    self:add_entry(self.levels.INFO, msg, event)
end

---Add a log entry at WARN level
---@param msg any
---@param event any
function Log:warn(msg, event)
    -- Fixed: typo - was self.levelsWARN, should be self.levels.WARN
    self:add_entry(self.levels.WARN, msg, event)
end

---Add a log entry at ERROR level
---@param msg any
---@param event any
function Log:error(msg, event)
    self:add_entry(self.levels.ERROR, msg, event)
end

setmetatable({}, Log)

return Log
