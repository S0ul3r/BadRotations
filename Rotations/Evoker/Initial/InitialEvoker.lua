local rotationName = "Initial" -- Change to name of profile listed in options drop down

---------------
--- Toggles ---
---------------
local function createToggles() -- Define custom toggles
    -- Rotation Button
    local RotationModes = {
        [1] = {
            mode = "Auto",
            value = 1,
            overlay = "Automatic Rotation",
            tip = "Swaps between Single and Multiple based on number of #enemies.yards8 in range.",
            highlight = 1,
            icon = br.player.spells.disintegrate
        },
        [2] = {
            mode = "Mult",
            value = 2,
            overlay = "Multiple Target Rotation",
            tip = "Multiple target rotation used.",
            highlight = 1,
            icon = br.player.spells.azureStrike
        },
        [3] = {
            mode = "Sing",
            value = 3,
            overlay = "Single Target Rotation",
            tip = "Single target rotation used.",
            highlight = 1,
            icon = br.player.spells.livingFlame
        },
        [4] = {
            mode = "Off",
            value = 4,
            overlay = "DPS Rotation Disabled",
            tip = "Disable DPS Rotation",
            highlight = 0,
            icon = br.player.spells.blessingOfTheBronze
        }
    };
    br.ui:createToggle(RotationModes, "Rotation", 1, 0)
    -- Cooldown Button
    local CooldownModes = {
        [1] = {
            mode = "Auto",
            value = 1,
            overlay = "Cooldowns Automated",
            tip = "Automatic Cooldowns - Boss Detection.",
            highlight = 1,
            icon = br.player.spells.furyOfTheAspects
        },
        [2] = {
            mode = "On",
            value = 2,
            overlay = "Cooldowns Enabled",
            tip = "Cooldowns used regardless of target.",
            highlight = 0,
            icon = br.player.spells.furyOfTheAspects
        },
        [3] = {
            mode = "Off",
            value = 3,
            overlay = "Cooldowns Disabled",
            tip = "No Cooldowns will be used.",
            highlight = 0,
            icon = br.player.spells.furyOfTheAspects
        }
    };
    br.ui:createToggle(CooldownModes, "Cooldown", 2, 0)
    -- Defensive Button
    local DefensiveModes = {
        [1] = {
            mode = "On",
            value = 1,
            overlay = "Defensive Enabled",
            tip = "Includes Defensive Cooldowns.",
            highlight = 1,
            icon = br.player.spells.livingFlame
        },
        [2] = {
            mode = "Off",
            value = 2,
            overlay = "Defensive Disabled",
            tip = "No Defensives will be used.",
            highlight = 0,
            icon = br.player.spells.livingFlame
        }
    };
    br.ui:createToggle(DefensiveModes, "Defensive", 3, 0)
    -- Interrupt Button
    local InterruptModes = {
        [1] = {
            mode = "On",
            value = 1,
            overlay = "Interrupts Enabled",
            tip = "Includes Basic Interrupts.",
            highlight = 1,
            icon = br.player.spells.tailSwipe
        },
        [2] = {
            mode = "Off",
            value = 2,
            overlay = "Interrupts Disabled",
            tip = "No Interrupts will be used.",
            highlight = 0,
            icon = br.player.spells.tailSwipe
        }
    };
    br.ui:createToggle(InterruptModes, "Interrupt", 4, 0)
end

---------------
--- OPTIONS ---
---------------
local function createOptions()
    local optionTable

    local function rotationOptions()
        local section
        -----------------------
        --- GENERAL OPTIONS --- -- Define General Options
        -----------------------
        section = br.ui:createSection(br.ui.window.profile, "General")
        br.ui:createSpinner(section, "DPS Testing", 5, 5, 60, 5,
            "|cffFFFFFFSet to desired time for test in minuts. Min: 5 / Max: 60 / Interval: 5")
        -- Blessing of the Bronze
        br.ui:createCheckbox(section, "Blessing of the Bronze")
        -- Stage Limiter
        br.ui:createCheckbox(section, "Empower Stage Limiter", "|cffFFFFFFEnable to set maximum stages to Empower to.")
        br.ui:createSpinnerWithout(section, "Fire Breath Stage Limit", 4, 1, 4, 1, "")
        br.ui:checkSectionState(section)
        ------------------------
        --- COOLDOWN OPTIONS --- -- Define Cooldown Options
        ------------------------
        section = br.ui:createSection(br.ui.window.profile, "Cooldowns")
        local alwaysCdAoENever = { "Always", "|cff008000AOE", "|cffffff00AOE/CD", "|cff0000ffCD", "|cffff0000Never" }
        -- Deep Breath
        br.ui:createDropdownWithout(section, "Deep Breath", alwaysCdAoENever, 3,
            "|cffFFFFFFWhen to use Deep Breath Ability.")
        br.ui:checkSectionState(section)
        -------------------------
        --- DEFENSIVE OPTIONS --- -- Define Defensive Options
        -------------------------
        section = br.ui:createSection(br.ui.window.profile, "Defensive")
        -- Emerald Blossom
        br.ui:createSpinner(section, "Emerald Blossom", 35, 0, 99, 5, "Use Emerald Blossom to Heal below this threshold")
        -- Living Flame
        br.ui:createSpinner(section, "Living Flame Heal", 45, 0, 99, 5, "Use Living Flame to Heal below this threshold")
        -- Return
        br.ui:createCheckbox(section, "Return")
        br.ui:createDropdownWithout(section, "Return - Target", { "|cff00FF00Target", "|cffFF0000Mouseover" }, 1,
            "|cffFFFFFFTarget to cast on")
        -- Wing Buffet
        br.ui:createSpinner(section, "Wing Buffet - HP", 50, 0, 100, 5, "|cffFFFFFFHealth Percent to Cast At")
        br.ui:createSpinner(section, "Wing Buffet - AoE", 5, 0, 10, 1, "|cffFFFFFFNumber of Units in 5 Yards to Cast At")
        br.ui:checkSectionState(section)
        -------------------------
        --- INTERRUPT OPTIONS --- -- Define Interrupt Options
        -------------------------
        section = br.ui:createSection(br.ui.window.profile, "Interrupts")
        -- Tail Swipe
        br.ui:createCheckbox(section, "Tail Swipe")
        -- Interrupt Percentage
        br.ui:createSpinnerWithout(section, "InterruptAt", 0, 0, 95, 5, "|cffFFBB00Cast Percentage to use at.")
        br.ui:checkSectionState(section)
        ----------------------
        --- TOGGLE OPTIONS --- -- Degine Toggle Options
        ----------------------
        section = br.ui:createSection(br.ui.window.profile, "Toggle Keys")
        -- Single/Multi Toggle
        br.ui:createDropdownWithout(section, "Rotation Mode", br.dropOptions.Toggle, 4)
        -- Cooldown Key Toggle
        br.ui:createDropdownWithout(section, "Cooldown Mode", br.dropOptions.Toggle, 3)
        -- Defensive Key Toggle
        br.ui:createDropdownWithout(section, "Defensive Mode", br.dropOptions.Toggle, 6)
        -- Interrupts Key Toggle
        br.ui:createDropdownWithout(section, "Interrupt Mode", br.dropOptions.Toggle, 6)
        br.ui:checkSectionState(section)
    end
    optionTable = { {
        [1] = "Rotation Options",
        [2] = rotationOptions
    } }
    return optionTable
end

--------------
--- Locals ---
--------------
-- BR API Locals - Many of these are located from System/API, this is a sample of commonly used ones but no all inclusive
local buff
local cast
local cd
local debuff
local enemies
local essence
local module
local spell
local ui
local unit
local units
local var
-- General Locals - Common Non-BR API Locals used in profiles
-- Profile Specific Locals - Any custom to profile locals
local actionList = {}
local custom = {}

-----------------
--- Functions --- -- List all profile specific custom functions here
-----------------
custom.stageLimit = function(empowerSpell, requestedStage)
    if ui.checked("Empower Stage Limiter") then
        if empowerSpell == "FB" then return ui.value("Fire Breath Stage Limit") end
        -- if empowerSpell == "ES" then return ui.value("Eternity Surge Stage Limit") end
    end
    return requestedStage
end

--------------------
--- Action Lists ---
--------------------
-- Action List - Extra
actionList.Extra = function()
    -- Dummy Test
    if ui.checked("DPS Testing") then
        if unit.exists("target") then
            if unit.combatTime() >= (tonumber(ui.value("DPS Testing")) * 60) and unit.isDummy() then
                unit.stopAttack()
                unit.clearTarget()
                ui.print(tonumber(ui.value("DPS Testing")) .. " Minute Dummy Test Concluded - Profile Stopped")
                var.profileStop = true
            end
        end
    end -- End Dummy Test-- Dummy DPS Test
    -- Blessing of the Bronze
    if ui.checked("Blessing of the Bronze") and cast.able.blessingOfTheBronze("player") then
        for i = 1, #br.friend do
            local thisUnit = br.friend[i].unit
            if not unit.deadOrGhost(thisUnit) and unit.distance(thisUnit) < 40 and buff.blessingOfTheBronze.remain(thisUnit) < 600 then
                if cast.blessingOfTheBronze("player") then
                    ui.debug("Casting Blessing of the Bronze")
                    return true
                end
            end
        end
    end
end -- End Action List - Extra

-- Action List - Defensive
actionList.Defensive = function()
    if ui.useDefensive() and not unit.mounted() then
        local opValue
        local thisUnit
        -- Basic Healing
        module.BasicHealing()
        -- Emerald Blossom
        if ui.checked("Emerald Blossom") and cast.able.emeraldBlossom("player") and unit.hp() <= ui.value("Emerald Blossom") then
            if cast.emeraldBlossom("player") then
                ui.debug("Casting Emerald Blossom")
                return true
            end
        end
        -- Living Flame
        if ui.checked("Living Flame Heal") and not unit.moving() then
            thisUnit = unit.friend("target") and "target" or "player"
            if cast.able.livingFlame(thisUnit) and unit.hp(thisUnit) <= ui.value("Living Flame Heal") then
                if cast.livingFlame(thisUnit) then
                    ui.debug("Casting Living Flame on " .. unit.name(thisUnit))
                    return true
                end
            end
        end
        -- Return
        if ui.checked("Return") and not unit.inCombat() and not unit.moving() then
            opValue = ui.value("Return - Target")
            if opValue == 1 then
                thisUnit = "target"
            elseif opValue == 2 then
                thisUnit = "mouseover"
            end
            if cast.able.returnEvoker(thisUnit, "dead") and unit.deadOrGhost(thisUnit)
                and (unit.friend(thisUnit) and unit.player(thisUnit))
            then
                if cast.returnEvoker(thisUnit, "dead") then
                    ui.debug("Casting Return on " .. unit.name(thisUnit))
                    return true
                end
            end
        end
        -- Wing Buffet
        if ui.checked("Wing Buffet - HP") and unit.hp() <= ui.value("Wing Buffet - HP")
            and cast.able.wingBuffet() and unit.inCombat() and #enemies.yards15f > 0
        then
            if cast.wingBuffet() then
                ui.debug("Casting Wing Buffet [HP]")
                return true
            end
        end
        if ui.checked("Wing Buffet - AoE") and #enemies.yards15f >= ui.value("Wing Buffet - AoE")
            and cast.able.wingBuffet()
        then
            if cast.wingBuffet() then
                ui.debug("Casting Wing Buffet [AOE]")
                return true
            end
        end
    end
end -- End Action List - Defensive

-- Action List - Interrupt
actionList.Interrupt = function()
    if ui.useInterrupt() then
        for i = 1, #enemies.yards8 do
            local thisUnit = enemies.yards8[i]
            if br.canInterrupt(thisUnit, ui.value("Interrupt At")) then
                -- Tail Swipe
                if ui.checked("Tail Swipe") and cast.able.tailSwipe(thisUnit) and unit.distance(thisUnit) < 8 then
                    if cast.tailSwipe(thisUnit) then
                        ui.debug("Casting Tail Swipe [Interrupt]")
                        return true
                    end
                end
            end
        end
    end -- End Interrupt Check
end     -- End Action List - Interrupt

-- Action List - Cooldowns
actionList.Cooldowns = function()
    -- Deep Breath
    if ui.alwaysCdAoENever("Deep Breath", 1, 20) and cast.able.deepBreath("player", "rect", 1, 20) then
        if cast.deepBreath("player", "rect", 1, 20) then
            ui.debug("Casting Deep Breath [Cooldowns]")
            return true
        end
    end
end -- End Action List - Cooldowns

-- Action List - Pre-Combat
actionList.PreCombat = function()
    if not unit.inCombat() and not unit.mounted() then
        if unit.valid("target") then
            -- Living Flame
            if cast.able.livingFlame("target") and not unit.moving() and not cast.current.livingFlame() then
                if cast.livingFlame("target") then
                    ui.debug("Casting Living Flame [Pre-Combat]")
                    return true
                end
            end
            -- Start Attack
            if unit.distance("target") < 5 then
                if cast.able.autoAttack("target") then
                    if cast.autoAttack("target") then
                        ui.debug("Casting Auto Attack [Pre-Combat]")
                        return true
                    end
                end
            end
        end
    end
end -- End Action List - PreCombat

-- Action list - Combat
actionList.Combat = function()
    if unit.valid("target") and (cd.global.remain() == 0 or var.fireBreathStage > 0) then
        if unit.exists(units.dyn40) and unit.distance(units.dyn40) < 40 then
            -----------------
            --- Interrupt ---
            -----------------
            if actionList.Interrupt() then return true end
            -----------------
            --- Cooldowns ---
            -----------------
            if actionList.Cooldowns() then return true end
            ------------
            --- Main ---
            ------------
            -- Fire Breath
            -- if cast.able.fireBreath("player") and var.moveCast and not cast.current.fireBreath() then
            --     if var.fireBreathStage == 0 then
            --         if cast.fireBreath("player") then
            --             ui.debug("Casting Fire Breath")
            --             return true
            --         end
            --     end
            --     if var.fireBreathStage >= ui.value("Fire Breath Stage") then
            --         if cast.fireBreath("player") then
            --             ui.debug("Casting Fire Breath - Empowered Stage " .. var.fireBreathStage)
            --             return true
            --         end
            --     end
            -- end
            -- Fire Breath
            if cast.able.fireBreath("player", "cone", 1, 25) and var.moveCast and not cast.current.fireBreath() then
                -- fire_breath,empower_to=1,if=(20+2*talent.blast_furnace.rank)+dot.fire_breath_damage.remains<(20+2*talent.blast_furnace.rank)*1.3|buff.dragonrage.remains<1.75*spell_haste&buff.dragonrage.remains>=1*spell_haste|active_enemies<=2
                if 20 + debuff.fireBreath.remains(units.dyn25) < 20 * 1.3
                    or buff.dragonrage.remains() < 1.75 * var.spellHaste and buff.dragonrage.remains() >= 1 * var.spellHaste or #enemies.yards25f <= 2
                then
                    if cast.fireBreath("player", "cone", 1, 25) then
                        var.stageFireBreath = custom.stageLimit("FB", 1)
                        ui.debug("Empowering Fire Breath to Stage " .. var.stageFireBreath .. " [FB]")
                        return true
                    end
                end
                -- fire_breath,empower_to=2,if=(14+2*talent.blast_furnace.rank)+dot.fire_breath_damage.remains<(20+2*talent.blast_furnace.rank)*1.3|buff.dragonrage.remains<2.5*spell_haste&buff.dragonrage.remains>=1.75*spell_haste
                if 14 + debuff.fireBreath.remains(units.dyn25) < 20 * 1.3
                    or buff.dragonrage.remains() < 2.5 * var.spellHaste and buff.dragonrage.remains() >= 1.75 * var.spellHaste
                then
                    if cast.fireBreath("player", "cone", 1, 25) then
                        var.stageFireBreath = custom.stageLimit("FB", 2)
                        ui.debug("Empowering Fire Breath to Stage " .. var.stageFireBreath .. " [FB]")
                        return true
                    end
                end
                -- fire_breath,empower_to=3,if=(8+2*talent.blast_furnace.rank)+dot.fire_breath_damage.remains<(20+2*talent.blast_furnace.rank)*1.3|!talent.font_of_magic|buff.dragonrage.remains<=3.25*spell_haste&buff.dragonrage.remains>=2.5*spell_haste
                if 8 + debuff.fireBreath.remains(units.dyn25) < 20 * 1.3
                    or buff.dragonrage.remains() < 3.25 * var.spellHaste and buff.dragonrage.remains() >= 2.5 * var.spellHaste
                then
                    if cast.fireBreath("player", "cone", 1, 25) then
                        var.stageFireBreath = custom.stageLimit("FB", 3)
                        ui.debug("Empowering Fire Breath to Stage " .. var.stageFireBreath .. " [FB]")
                        return true
                    end
                end
                -- fire_breath,empower_to=4
                if cast.fireBreath("player", "cone", 1, 25) then
                    var.stageFireBreath = custom.stageLimit("FB", 4)
                    ui.debug("Empowering Fire Breath to Stage " .. var.stageFireBreath .. " [FB]")
                    return true
                end
            end
            -- Disintegrate
            if cast.able.disintegrate() and essence() >= 3 and var.moveCast then
                if cast.disintegrate() then
                    ui.debug("Casting Disintegrate")
                    return true
                end
            end
            -- Azure Strike
            if cast.able.azureStrike() and ui.useAOE(25, 2) then
                if cast.azureStrike() then
                    ui.debug("Casting Azure Strike")
                    return true
                end
            end
            -- Living Flame
            if cast.able.livingFlame(units.dyn25) and var.moveCast and ui.useST(25, 2) then
                if cast.livingFlame(units.dyn25) then
                    ui.debug("Casting Living Flame")
                    return true
                end
            end
        end -- End In Combat Rotation
    end
end         -- End Action List - Combat

---------------- -
--- ROTATION ---
----------------
local function runRotation()
    ---------------------
    --- Define Locals ---
    ---------------------
    -- BR API Locals
    buff    = br.player.buff
    cast    = br.player.cast
    cd      = br.player.cd
    debuff  = br.player.debuff
    enemies = br.player.enemies
    essence = br.player.power.essence
    module  = br.player.module
    spell   = br.player.spells
    ui      = br.player.ui
    unit    = br.player.unit
    units   = br.player.units
    var     = br.player.variables
    -- General Locals
    if var.fireBreathStage == nil or br.empowerID ~= spell.fireBreath then var.fireBreathStage = 0 end
    if cast.empowered.fireBreath() > 0 then
        var.fireBreathStage = cast.empowered.fireBreath()
    end
    var.moveCast = (not unit.moving() or buff.hover.exists())
    var.profileStop = false
    var.haltProfile = (unit.inCombat() and var.profileStop) or unit.mounted() or br.pause() or ui.mode.rotation == 4

    -- Fire Breath Stage
    if var.stageFireBreath == nil then var.stageFireBreath = 0 end
    if var.fireBreathStage == nil or br.empowerID ~= spell.fireBreath then var.fireBreathStage = 0; end
    if cast.empowered.fireBreath() > 0 then
        var.fireBreathStage = cast.empowered.fireBreath()
    end
    if var.pauseForFbCd == nil then var.pauseForFbCd = false end

    -- Units
    units.get(25)
    units.get(40)
    -- Enemies
    enemies.get(8)
    enemies.get(15, "player", false, true) -- makes enemies.yards15f
    enemies.get(25, "player", false, true)

    -- Cancel if casting with no enemies
    if #enemies.yards25f == 0 then
        if var.fireBreathStage > 0 then
            if cast.cancel.fireBreath() then
                ui.debug("Canceling Fire Breath [No Enemies in Range]")
                return true
            end
        end
    end

    -- End Fire Breath Cast at Stage
    if var.stageFireBreath > 0 and var.fireBreathStage == var.stageFireBreath then
        if cast.fireBreath("player") then
            var.stageFireBreath = 0
            ui.debug("Casting Fire Breath at Empowered Stage " .. var.fireBreathStage)
            return true
        end
    end

    ---------------------
    --- Begin Profile ---
    ---------------------
    -- Profile Stop | Pause
    if not unit.inCombat() and not unit.exists("target") and var.profileStop then
        var.profileStop = false
    elseif var.haltProfile and cast.current.id() ~= br.empowerID then
        return true
    else
        -------------
        --- Extra ---
        -------------
        if actionList.Extra() then return true end
        -----------------
        --- Defensive ---
        -----------------
        if actionList.Defensive() then return true end
        ------------------
        --- Pre-Combat ---
        ------------------
        if actionList.PreCombat() then return true end
        --------------
        --- Combat ---
        --------------
        if actionList.Combat() then return true end
    end         -- Pause
end             -- End runRotation
local id = 1465 -- Change to the spec id profile is for.
if br.rotations[id] == nil then
    br.rotations[id] = {}
end
br._G.tinsert(br.rotations[id], {
    name = rotationName,
    toggles = createToggles,
    options = createOptions,
    run = runRotation
})
