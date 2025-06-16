-- MR19_Animaciones
-- Gestiona las Animaciones
-- Autor: ElTitoJet
-- Fecha: 16/08/2024

-- Variables Globales y Configuración
    local animacionesJugadores = {}

    local animacionesSentarse = {
      [1] = {"attractors", "stepsit_loop"},
      [2] = {"car", "sit_relaxed"},
      [3] = {"car", "tap_hand"},
      [4] = {"crib", "ped_console_loop"},
      [5] = {"food", "ff_sit_eat1"},
      [6] = {"food", "ff_sit_look"},
      [7] = {"int_house", "lou_loop"},
      [8] = {"int_office", "off_sit_idle_loop"},
      [9] = {"jst_buisness", "girl_02"},
      [10] = {"misc", "seat_lr"},
      [11] = {"misc", "seat_talk_01"},
    }
    local animacionesApoyarse = {
      [1] = {"bar", "barserve_loop"},
      [2] = {"bd_fire", "bd_panic_04"},
      [3] = {"bd_fire", "bd_panic_loop"},
      [4] = {"bd_fire", "m_smklean_loop"},
      [5] = {"beach", "lay_bac_loop"},
      [6] = {"beach", "parksit_m_loop"},
      [7] = {"beach", "parksit_w_loop"},
      [8] = {"beach", "sitnwait_loop_w"},
      [9] = {"casino", "roulette_loop"},
      [10] = {"food", "shp_tray_pose"},
      [11] = {"misc", "plyrlean_loop"},
      
    }
    local animacionesBeber = {
      [1] = {"bar", "dnk_stndf_loop"},
      [2] = {"bar", "dnk_stndm_loop"},
    }
    local animacionesReparar = {
      [1] = {"bomber", "bom_plant_loop"},
      [2] = {"bomber", "fixn_car_loop"},
      [3] = {"bomber", "car_sc4_bl"},
      [4] = {"cop_ambient", "copbrowse_loop"},
      [5] = {"cop_ambient", "copbrowse_nod"},
      [6] = {"cop_ambient", "copbrowse_shake"},
      [7] = {"rob_bank", "cat_safe_rob"},
    }
    local animacionesCTM = {
      [1] = {"bsktball", "bball_react_miss"},
      [2] = {"bsktball", "bball_react_score"},
      [3] = {"bsktball", "casino"},
    }
    local animacionesCamara = {
      [1] = {"camera", "camcrch_cmon"},
      [2] = {"camera", "camcrch_idleloop"},
      [3] = {"camera", "camstnd_lkabt"},
      [4] = {"camera", "piccrch_take"},
    }
    local animacionesVendedor = {
      [1] = {"casino", "cards_loop"},
      [2] = {"casino", "cards_pick_01"},
      [3] = {"casino", "cards_pick_02"},
      [4] = {"casino", "cards_raise"},
    }
    local animacionesPerdedor = {
      [1] = {"casino", "roulette_lose"},
      [2] = {"casino", "slot_lose_out"},
    }
    local animacionesTocar = {
      [1] = {"casino", "slot_plyr"},
      [2] = {"crib", "crib_use_switch"},
    }
    local animacionesTomar = {
      [1] = {"casino", "slot_win_out"},
    }
    local animacionesPose = {
      [1] = {"clothes", "clo_pose_loop"},
      [2] = {"clothes", "clo_pose_shoes"},
      [3] = {"clothes", "clo_pose_torso"},
      [4] = {"clothes", "clo_pose_watch"},
      [5] = {"ped", "car_hookertalk"},
    }
    local animacionesCruzarBrazos = {
      [1] = {"cop_ambient", "coplook_loop"},
      [2] = {"otb", "wtchrace_loop"},
    }
    local animacionesEsperar = {
      [1] = {"cop_ambient", "coplook_nod"},
      [2] = {"cop_ambient", "coplook_shake"},
    }
    local animacionesPensar = {
      [1] = {"cop_ambient", "coplook_think"},
    }
    local animacionesReloj = {
      [1] = {"cop_ambient", "coplook_watch"},
    }
    local animacionesBate = {
      [1] = {"crack", "bbalbat_idle_01"},
      [2] = {"crack", "bbalbat_idle_02"},
    }
    local animacionesDormir = {
      [1] = {"crack", "crckdeth2"},
      [2] = {"crack", "crckidle2"},
      [3] = {"crack", "crckidle3"},
    }
    local animacionesHerido = {
      [1] = {"crack", "crckidle1"},
      [2] = {"crack", "crckidle4"},
      [3] = {"swat", "gnstwall_injurd"},
      [4] = {"sweet", "sweet_injuredloop"},
      [5] = {"wuzi", "cs_dead_guy"},
    }
    local animacionesBaile = {
      [1] = {"dancing", "dance_loop"},
      [2] = {"dancing", "dan_down_a"},
      [3] = {"dancing", "dan_left_a"},
      [4] = {"dancing", "dan_loop_a"},
      [5] = {"dancing", "dan_right_a"},
      [6] = {"dancing", "dan_up_a"},
      [7] = {"dancing", "dnce_m_a"},
      [8] = {"dancing", "dnce_m_b"},
      [9] = {"dancing", "dnce_m_c"},
      [10] = {"dancing", "dnce_m_d"},
      [11] = {"dancing", "dnce_m_e"},
    }
    local animacionesGuardia = {
      [1] = {"dealer", "dealer_deal"},
      [2] = {"dealer", "dealer_idle"},
      [3] = {"dealer", "dealer_idle_01"},
      [4] = {"dealer", "dealer_idle_02"},
      [5] = {"dealer", "dealer_idle_03"},
    }
    local animacionesCansado = {
      [1] = {"fat", "idle_tired"},
      [2] = {"ped", "idle_tired"},
    }
    local animacionesComer = {
      [1] = {"food", "eat_burger"},
      [2] = {"food", "eat_chicken"},
      [3] = {"food", "eat_pizza"},
    }
    local animacionesVomitar = {
      [1] = {"food", "eat_vomit_p"},
    }
    local animacionesAsco = {
      [1] = {"food", "eat_vomit_sk"},
    }
    local animacionesFestejo = {
      [1] = {"freeweights", "gym_free_celebrate"},
    }
    local animacionesFumar = {
      [1] = {"gangs", "smkcig_prtl"},
      [2] = {"lowrider", "m_smklean_loop"},
      [3] = {"smoking", "f_smklean_loop"},
      [4] = {"smoking", "m_smkstnd_loop"},
      [5] = {"smoking", "m_smk_drag"},
    }
    local animacionesNo = {
      [1] = {"gangs", "invite_no"},
      [2] = {"kissing", "gf_streetargue_02"},
      [2] = {"ped", "endchat_02"},
      
    }
    local animacionesSi = {
      [1] = {"gangs", "invite_yes"},
    }
    local animacionesGang = {
      [1] = {"ghands", "gsign1"},
      [2] = {"ghands", "gsign1lh"},
      [3] = {"ghands", "gsign2"},
      [4] = {"ghands", "gsign2lh"},
      [5] = {"ghands", "gsign3"},
      [6] = {"ghands", "gsign3lh"},
      [7] = {"ghands", "gsign4"},
      [8] = {"ghands", "gsign4lh"},
      [9] = {"ghands", "gsign5"},
      [10] = {"ghands", "gsign5lh"},
      [11] = {"playidles", "time"},
    }
    local animacionesLlorar = {
      [1] = {"graveyard", "mrnf_loop"},
    }
    local animacionesPararse = {
      [1] = {"graveyard", "mrnm_loop"},
      [2] = {"haircuts", "brb_buy"},
      [3] = {"playidles", "shldr"},
      [4] = {"playidles", "strleg"},
    }
    local animacionesEscribir = {
      [1] = {"int_office", "off_sit_type_loop"},
    }
    local animacionesSaludar = {
      [1] = {"kissing", "gfwave2"},
      [2] = {"ped", "endchat_03"},
    }
    local animacionesNose = {
      [1] = {"lowrider", "prtial_gngtlkb"},
    }
    local animacionesQuepaso = {
      [1] = {"lowrider", "prtial_gngtlkc"},
      [2] = {"lowrider", "prtial_gngtlkf"},
      [3] = {"lowrider", "prtial_gngtlkg"},
      [4] = {"lowrider", "prtial_gngtlkh"},
      [5] = {"riot", "riot_angry"},
    }
    local animacionesRap = {
      [1] = {"lowrider", "rap_a_loop"},
      [2] = {"lowrider", "rap_b_loop"},
      [3] = {"lowrider", "rap_c_loop"},
    }
    local animacionesRCP = {
      [1] = {"medic", "cpr"},
    }
    local animacionesApuntar = {
      [1] = {"misc", "hiker_pose"},
      [2] = {"misc", "hiker_pose_l"},
      [3] = {"on_lookers", "pointup_loop"},
      [4] = {"ped", "gang_gunstand"},
    }
    local animacionesFacepalm = {
      [1] = {"misc", "plyr_shkhead"},
    }
    local animacionesRascar = {
      [1] = {"misc", "scratchballs_01"},
    }
    local animacionesBuscar = {
      [1] = {"on_lookers", "lkaround_loop"},
    }
    local animacionesAlentar = {
      [1] = {"on_lookers", "shout_01"},
      [2] = {"on_lookers", "shout_02"},
      [3] = {"on_lookers", "wave_loop"},
      [4] = {"riot", "riot_angry_b"},
      [5] = {"riot", "riot_chant"},
      [6] = {"riot", "riot_punches"},
      [7] = {"ryder", "ryd_beckon_01"},
      [8] = {"ryder", "ryd_beckon_02"},
      [9] = {"strip", "pun_holler"},
    }
    local animacionesTaichi = {
      [1] = {"park", "tai_chi_loop"},
    }
    local animacionesMear = {
      [1] = {"paulnmac", "piss_loop"},
    }
    local animacionesPaja = {
      [1] = {"paulnmac", "wank_loop"},
    }
    local animacionesAsustado = {
      [1] = {"ped", "duck_cower"},
    }    
    local animacionesQueteden = {
      [1] = {"ped", "fucku"},
      [1] = {"riot", "riot_fuku"},
    }
    local animacionesCaer = {
      -- Block, anim, time, loop, freezeLastFrame
      [1] = {"ped", "FLOOR_hit", 1000, false, true},
      [2] = {"ped", "FLOOR_hit_f", 1000, false, true},
      [3] = {"ped", "ko_shot_stom", 1000, false, true},
      [4] = {"ped", "ko_shot_face", 1000, false, true},
      [5] = {"ped", "ko_spin_r", 1000, false, true},
      [6] = {"ped", "ko_skid_front", 1000, false, true}
    }
    local animacionesEstirar = {
      [1] = {"playidles", "stretch"},
    }
    local animacionesTrafico = {
      [1] = {"police", "coptraf_away"},
      [2] = {"police", "coptraf_come"},
      [3] = {"police", "coptraf_left"},
      [4] = {"police", "coptraf_stop"},
    }
    local animacionesPatear = {
      [1] = {"police", "door_kick"},
    }
    local animacionesReir = {
      [1] = {"rapping", "laugh_01"},
    }
    local animacionesDJ = {
      [1] = {"scratching", "scdldlp"},
      [2] = {"scratching", "scdlulp"},
      [3] = {"scratching", "scdrdlp"},
      [4] = {"scratching", "scdrulp"},
      [5] = {"scratching", "sclng_l"},
      [6] = {"scratching", "sclng_r"},
      [7] = {"scratching", "scmid_l"},
      [8] = {"scratching", "scmid_r"},
      [9] = {"scratching", "scshrtl"},
      [10] = {"scratching", "scshrtr"},
      [11] = {"scratching", "sc_ltor"},
      [12] = {"scratching", "sc_rtol"},
    }
    local animacionesRendirse = {
      [1] = {"shop", "shp_rob_handsup"},
    }
    local animacionesStrip = {
      [1] = {"strip", "strip_a"},
      [2] = {"strip", "strip_b"},
      [3] = {"strip", "strip_c"},
      [4] = {"strip", "strip_d"},
      [5] = {"strip", "strip_e"},
      [6] = {"strip", "strip_f"},
      [7] = {"strip", "strip_g"},
      [8] = {"strip", "str_c1"},
      [9] = {"strip", "str_c2"},
      [10] = {"strip", "str_loop_a"},
      [11] = {"strip", "str_loop_b"},
      [12] = {"strip", "str_loop_c"},
    }
    local animacionesTirarse = {
      [1] = {"sunbathe", "parksit_m_idlea"},
      [2] = {"sunbathe", "parksit_m_idleb"},
      [3] = {"sunbathe", "parksit_m_idlec"},
      [4] = {"sunbathe", "parksit_w_idlea"},
      [5] = {"sunbathe", "parksit_w_idleb"},
      [6] = {"sunbathe", "parksit_w_idlec"},
    }
-- Funciones Auxiliares
    function gestionarAnimacion(source, group, animacion, time, loop, freezeLastFrame)
      if not group then
        return
      end
      --iprint("2 - ")
      --iprint(source, group, animacion, time, loop, freezeLastFrame)
        local varDataSource = exports["MR1_Inicio"]:getValueOne(source)
        if varDataSource.Estado["Taseado"] == true then
          return
        end
        --iprint(source, group, animacion, time, loop, updatePosition, interruptable, freezeLastFrame)

        local loop = loop or false
        local freeze = freezeLastFrame or false

        if not animacionesJugadores[source] then
          -- Iniciar la animación
          animacionesJugadores[source] = {group, animacion}
          
          --iprint("3 - ")
          --iprint(source, group, animacion, time, loop, freeze)
          --setPedAnimation(source, group, animacion, time, loop, freeze, false)
          setPedAnimation(source, group, animacion)
          setTimer(function(source, animacion)
            setPedAnimationProgress(source, animacion, 0.5)
          end, 50, 2, source, animacion)
          -- Enviar solo al jugador correcto
          triggerClientEvent(source, "syncAnimacion", source,  group, animacion, time, loop, freeze)
          if group == "shop" and animacion == "shp_rob_handsup" then
              exports["MR1_Inicio"]:setValue(source, "Rendirse", true)
          end
        else
            -- Detener la animación
            animacionesJugadores[source] = nil
            setPedAnimation(source, false)
            --triggerClientEvent(source, "syncAnimacion", source, false)
            if group == "shop" and animacion == "shp_rob_handsup" then
              exports["MR1_Inicio"]:setValue(source, "Rendirse", false)
          end
        end
        triggerClientEvent("syncAnimacionesTabla", root, animacionesJugadores)
    end
    
-- Funciones Principales
    function Sentarse(source, command, id)
        local idAnim = tonumber(id)
        local cantidadAnimaciones = #animacionesSentarse
        if idAnim and animacionesSentarse[idAnim] then
            local group, animacion = unpack(animacionesSentarse[idAnim])
            gestionarAnimacion(source, group, animacion)
        else
            gestionarAnimacion(source, nil, nil)
            outputChatBox("#FF0000Uso incorrecto. Usa: /sentarse [1-"..cantidadAnimaciones.."]", source, 255, 255, 255, true)
        end
    end
    function Apoyarse(source, command, id)
      local idAnim = tonumber(id)
      local cantidadAnimaciones = #animacionesApoyarse
      if idAnim and animacionesApoyarse[idAnim] then
        local group, animacion = unpack(animacionesApoyarse[idAnim])
        gestionarAnimacion(source, group, animacion)
      else
        gestionarAnimacion(source, nil, nil)
        outputChatBox("#FF0000Uso incorrecto. Usa: /apoyarse [1-"..cantidadAnimaciones.."]", source, 255, 255, 255, true)
      end
    end
    function Beber(source, command, id)
      local idAnim = tonumber(id)
      local cantidadAnimaciones = #animacionesBeber
      if idAnim and animacionesBeber[idAnim] then
        local group, animacion = unpack(animacionesBeber[idAnim])
        gestionarAnimacion(source, group, animacion)
      else
        gestionarAnimacion(source, nil, nil)
        outputChatBox("#FF0000Uso incorrecto. Usa: /beber [1-"..cantidadAnimaciones.."]", source, 255, 255, 255, true)
      end
    end
    function Reparar(source, command, id)
      local idAnim = tonumber(id)
      local cantidadAnimaciones = #animacionesReparar
      if idAnim and animacionesReparar[idAnim] then
        local group, animacion = unpack(animacionesReparar[idAnim])
        gestionarAnimacion(source, group, animacion)
      else
        gestionarAnimacion(source, nil, nil)
        outputChatBox("#FF0000Uso incorrecto. Usa: /reparar [1-"..cantidadAnimaciones.."]", source, 255, 255, 255, true)
      end
    end
    function CTM(source, command, id)
      local idAnim = tonumber(id)
      local cantidadAnimaciones = #animacionesCTM
      if idAnim and animacionesCTM[idAnim] then
        local group, animacion = unpack(animacionesCTM[idAnim])
        gestionarAnimacion(source, group, animacion)
      else
        gestionarAnimacion(source, nil, nil)
        outputChatBox("#FF0000Uso incorrecto. Usa: /ctm [1-"..cantidadAnimaciones.."]", source, 255, 255, 255, true)
      end
    end
    function Camara(source, command, id)
      local idAnim = tonumber(id)
      local cantidadAnimaciones = #animacionesCamara
      if idAnim and animacionesCamara[idAnim] then
        local group, animacion = unpack(animacionesCamara[idAnim])
        gestionarAnimacion(source, group, animacion)
      else
        gestionarAnimacion(source, nil, nil)
        outputChatBox("#FF0000Uso incorrecto. Usa: /camara [1-"..cantidadAnimaciones.."]", source, 255, 255, 255, true)
      end
    end
    function Vendedor(source, command, id)
      local idAnim = tonumber(id)
      local cantidadAnimaciones = #animacionesVendedor
      if idAnim and animacionesVendedor[idAnim] then
        local group, animacion = unpack(animacionesVendedor[idAnim])
        gestionarAnimacion(source, group, animacion)
      else
        gestionarAnimacion(source, nil, nil)
        outputChatBox("#FF0000Uso incorrecto. Usa: /vendedor [1-"..cantidadAnimaciones.."]", source, 255, 255, 255, true)
      end
    end
    function Perdedor(source, command, id)
      local idAnim = tonumber(id)
      local cantidadAnimaciones = #animacionesPerdedor
      if idAnim and animacionesPerdedor[idAnim] then
        local group, animacion = unpack(animacionesPerdedor[idAnim])
        gestionarAnimacion(source, group, animacion)
      else
        gestionarAnimacion(source, nil, nil)
        outputChatBox("#FF0000Uso incorrecto. Usa: /perdedor [1-"..cantidadAnimaciones.."]", source, 255, 255, 255, true)
      end
    end
    function Tocar(source, command, id)
      local idAnim = tonumber(id)
      local cantidadAnimaciones = #animacionesTocar
      if idAnim and animacionesTocar[idAnim] then
        local group, animacion = unpack(animacionesTocar[idAnim])
        gestionarAnimacion(source, group, animacion)
      else
        gestionarAnimacion(source, nil, nil)
        outputChatBox("#FF0000Uso incorrecto. Usa: /tocar [1-"..cantidadAnimaciones.."]", source, 255, 255, 255, true)
      end
    end
    function Tomar(source, command, id)
      local idAnim = tonumber(id)
      local cantidadAnimaciones = #animacionesTomar
      if idAnim and animacionesTomar[idAnim] then
        local group, animacion = unpack(animacionesTomar[idAnim])
        gestionarAnimacion(source, group, animacion)
      else
        gestionarAnimacion(source, nil, nil)
        outputChatBox("#FF0000Uso incorrecto. Usa: /tomar [1-"..cantidadAnimaciones.."]", source, 255, 255, 255, true)
      end
    end
    function Pose(source, command, id)
      local idAnim = tonumber(id)
      local cantidadAnimaciones = #animacionesPose
      if idAnim and animacionesPose[idAnim] then
        local group, animacion = unpack(animacionesPose[idAnim])
        gestionarAnimacion(source, group, animacion)
      else
        gestionarAnimacion(source, nil, nil)
        outputChatBox("#FF0000Uso incorrecto. Usa: /pose [1-"..cantidadAnimaciones.."]", source, 255, 255, 255, true)
      end
    end
    function CruzarBrazos(source, command, id)
      local idAnim = tonumber(id)
      local cantidadAnimaciones = #animacionesCruzarBrazos
      if idAnim and animacionesCruzarBrazos[idAnim] then
        local group, animacion = unpack(animacionesCruzarBrazos[idAnim])
        gestionarAnimacion(source, group, animacion)
      else
        gestionarAnimacion(source, nil, nil)
        outputChatBox("#FF0000Uso incorrecto. Usa: /cruzarbrazos [1-"..cantidadAnimaciones.."]", source, 255, 255, 255, true)
      end
    end
    function Esperar(source, command, id)
      local idAnim = tonumber(id)
      local cantidadAnimaciones = #animacionesEsperar
      if idAnim and animacionesEsperar[idAnim] then
        local group, animacion = unpack(animacionesEsperar[idAnim])
        gestionarAnimacion(source, group, animacion)
      else
        gestionarAnimacion(source, nil, nil)
        outputChatBox("#FF0000Uso incorrecto. Usa: /esperar [1-"..cantidadAnimaciones.."]", source, 255, 255, 255, true)
      end
    end
    function Pensar(source, command, id)
      local idAnim = tonumber(id)
      local cantidadAnimaciones = #animacionesPensar
      if idAnim and animacionesPensar[idAnim] then
        local group, animacion = unpack(animacionesPensar[idAnim])
        gestionarAnimacion(source, group, animacion)
      else
        gestionarAnimacion(source, nil, nil)
        outputChatBox("#FF0000Uso incorrecto. Usa: /pensar [1-"..cantidadAnimaciones.."]", source, 255, 255, 255, true)
      end
    end
    function Reloj(source, command, id)
      local idAnim = tonumber(id)
      local cantidadAnimaciones = #animacionesReloj
      if idAnim and animacionesReloj[idAnim] then
        local group, animacion = unpack(animacionesReloj[idAnim])
        gestionarAnimacion(source, group, animacion)
      else
        gestionarAnimacion(source, nil, nil)
        outputChatBox("#FF0000Uso incorrecto. Usa: /reloj [1-"..cantidadAnimaciones.."]", source, 255, 255, 255, true)
      end
    end
    function Bate(source, command, id)
      local idAnim = tonumber(id)
      local cantidadAnimaciones = #animacionesBate
      if idAnim and animacionesBate[idAnim] then
        local group, animacion = unpack(animacionesBate[idAnim])
        gestionarAnimacion(source, group, animacion)
      else
        gestionarAnimacion(source, nil, nil)
        outputChatBox("#FF0000Uso incorrecto. Usa: /bate [1-"..cantidadAnimaciones.."]", source, 255, 255, 255, true)
      end
    end
    function Dormir(source, command, id)
      local idAnim = tonumber(id)
      local cantidadAnimaciones = #animacionesDormir
      if idAnim and animacionesDormir[idAnim] then
        local group, animacion = unpack(animacionesDormir[idAnim])
        gestionarAnimacion(source, group, animacion)
      else
        gestionarAnimacion(source, nil, nil)
        outputChatBox("#FF0000Uso incorrecto. Usa: /dormir [1-"..cantidadAnimaciones.."]", source, 255, 255, 255, true)
      end
    end
    function Herido(source, command, id)
      local idAnim = tonumber(id)
      local cantidadAnimaciones = #animacionesHerido
      if idAnim and animacionesHerido[idAnim] then
        local group, animacion = unpack(animacionesHerido[idAnim])
        gestionarAnimacion(source, group, animacion)
      else
        gestionarAnimacion(source, nil, nil)
        outputChatBox("#FF0000Uso incorrecto. Usa: /herido [1-"..cantidadAnimaciones.."]", source, 255, 255, 255, true)
      end
    end
    function Baile(source, command, id)
      local idAnim = tonumber(id)
      local cantidadAnimaciones = #animacionesBaile
      if idAnim and animacionesBaile[idAnim] then
        local group, animacion = unpack(animacionesBaile[idAnim])
        gestionarAnimacion(source, group, animacion)
      else
        gestionarAnimacion(source, nil, nil)
        outputChatBox("#FF0000Uso incorrecto. Usa: /baile [1-"..cantidadAnimaciones.."]", source, 255, 255, 255, true)
      end
    end
    function Guardia(source, command, id)
      local idAnim = tonumber(id)
      local cantidadAnimaciones = #animacionesGuardia
      if idAnim and animacionesGuardia[idAnim] then
        local group, animacion = unpack(animacionesGuardia[idAnim])
        gestionarAnimacion(source, group, animacion)
      else
        gestionarAnimacion(source, nil, nil)
        outputChatBox("#FF0000Uso incorrecto. Usa: /guardia [1-"..cantidadAnimaciones.."]", source, 255, 255, 255, true)
      end
    end
    function Cansado(source, command, id)
      local idAnim = tonumber(id)
      local cantidadAnimaciones = #animacionesCansado
      if idAnim and animacionesCansado[idAnim] then
        local group, animacion = unpack(animacionesCansado[idAnim])
        gestionarAnimacion(source, group, animacion)
      else
        gestionarAnimacion(source, nil, nil)
        outputChatBox("#FF0000Uso incorrecto. Usa: /cansado [1-"..cantidadAnimaciones.."]", source, 255, 255, 255, true)
      end
    end
    function Comer(source, command, id)
      local idAnim = tonumber(id)
      local cantidadAnimaciones = #animacionesComer
      if idAnim and animacionesComer[idAnim] then
        local group, animacion = unpack(animacionesComer[idAnim])
        gestionarAnimacion(source, group, animacion)
      else
        gestionarAnimacion(source, nil, nil)
        outputChatBox("#FF0000Uso incorrecto. Usa: /comer [1-"..cantidadAnimaciones.."]", source, 255, 255, 255, true)
      end
    end
    function Vomitar(source, command, id)
      local idAnim = tonumber(id)
      local cantidadAnimaciones = #animacionesVomitar
      if idAnim and animacionesVomitar[idAnim] then
        local group, animacion = unpack(animacionesVomitar[idAnim])
        gestionarAnimacion(source, group, animacion)
      else
        gestionarAnimacion(source, nil, nil)
        outputChatBox("#FF0000Uso incorrecto. Usa: /vomitar [1-"..cantidadAnimaciones.."]", source, 255, 255, 255, true)
      end
    end
    function Asco(source, command, id)
      local idAnim = tonumber(id)
      local cantidadAnimaciones = #animacionesAsco
      if idAnim and animacionesAsco[idAnim] then
        local group, animacion = unpack(animacionesAsco[idAnim])
        gestionarAnimacion(source, group, animacion)
      else
        gestionarAnimacion(source, nil, nil)
        outputChatBox("#FF0000Uso incorrecto. Usa: /asco [1-"..cantidadAnimaciones.."]", source, 255, 255, 255, true)
      end
    end
    function Festejo(source, command, id)
      local idAnim = tonumber(id)
      local cantidadAnimaciones = #animacionesFestejo
      if idAnim and animacionesFestejo[idAnim] then
        local group, animacion = unpack(animacionesFestejo[idAnim])
        gestionarAnimacion(source, group, animacion)
      else
        gestionarAnimacion(source, nil, nil)
        outputChatBox("#FF0000Uso incorrecto. Usa: /festejo [1-"..cantidadAnimaciones.."]", source, 255, 255, 255, true)
      end
    end
    function Fumar(source, command, id)
      local idAnim = tonumber(id)
      local cantidadAnimaciones = #animacionesFumar
      if idAnim and animacionesFumar[idAnim] then
        local group, animacion = unpack(animacionesFumar[idAnim])
        gestionarAnimacion(source, group, animacion)
      else
        gestionarAnimacion(source, nil, nil)
        outputChatBox("#FF0000Uso incorrecto. Usa: /fumar [1-"..cantidadAnimaciones.."]", source, 255, 255, 255, true)
      end
    end
    function No(source, command, id)
      local idAnim = tonumber(id)
      local cantidadAnimaciones = #animacionesNo
      if idAnim and animacionesNo[idAnim] then
        local group, animacion = unpack(animacionesNo[idAnim])
        gestionarAnimacion(source, group, animacion)
      else
        gestionarAnimacion(source, nil, nil)
        outputChatBox("#FF0000Uso incorrecto. Usa: /no [1-"..cantidadAnimaciones.."]", source, 255, 255, 255, true)
      end
    end
    function Si(source, command, id)
      local idAnim = tonumber(id)
      local cantidadAnimaciones = #animacionesSi
      if idAnim and animacionesSi[idAnim] then
        local group, animacion = unpack(animacionesSi[idAnim])
        gestionarAnimacion(source, group, animacion)
      else
        gestionarAnimacion(source, nil, nil)
        outputChatBox("#FF0000Uso incorrecto. Usa: /si [1-"..cantidadAnimaciones.."]", source, 255, 255, 255, true)
      end
    end
    function Gang(source, command, id)
      local idAnim = tonumber(id)
      local cantidadAnimaciones = #animacionesGang
      if idAnim and animacionesGang[idAnim] then
        local group, animacion = unpack(animacionesGang[idAnim])
        gestionarAnimacion(source, group, animacion)
      else
        gestionarAnimacion(source, nil, nil)
        outputChatBox("#FF0000Uso incorrecto. Usa: /gang [1-"..cantidadAnimaciones.."]", source, 255, 255, 255, true)
      end
    end
    function Llorar(source, command, id)
      local idAnim = tonumber(id)
      local cantidadAnimaciones = #animacionesLlorar
      if idAnim and animacionesLlorar[idAnim] then
        local group, animacion = unpack(animacionesLlorar[idAnim])
        gestionarAnimacion(source, group, animacion)
      else
        gestionarAnimacion(source, nil, nil)
        outputChatBox("#FF0000Uso incorrecto. Usa: /llorar [1-"..cantidadAnimaciones.."]", source, 255, 255, 255, true)
      end
    end
    function Pararse(source, command, id)
      local idAnim = tonumber(id)
      local cantidadAnimaciones = #animacionesPararse
      if idAnim and animacionesPararse[idAnim] then
        local group, animacion = unpack(animacionesPararse[idAnim])
        gestionarAnimacion(source, group, animacion)
      else
        gestionarAnimacion(source, nil, nil)
        outputChatBox("#FF0000Uso incorrecto. Usa: /pararse [1-"..cantidadAnimaciones.."]", source, 255, 255, 255, true)
      end
    end
    function Escribir(source, command, id)
      local idAnim = tonumber(id)
      local cantidadAnimaciones = #animacionesEscribir
      if idAnim and animacionesEscribir[idAnim] then
        local group, animacion = unpack(animacionesEscribir[idAnim])
        gestionarAnimacion(source, group, animacion)
      else
        gestionarAnimacion(source, nil, nil)
        outputChatBox("#FF0000Uso incorrecto. Usa: /escribir [1-"..cantidadAnimaciones.."]", source, 255, 255, 255, true)
      end
    end
    function Saludar(source, command, id)
      local idAnim = tonumber(id)
      local cantidadAnimaciones = #animacionesSaludar
      if idAnim and animacionesSaludar[idAnim] then
        local group, animacion = unpack(animacionesSaludar[idAnim])
        gestionarAnimacion(source, group, animacion)
      else
        gestionarAnimacion(source, nil, nil)
        outputChatBox("#FF0000Uso incorrecto. Usa: /saludar [1-"..cantidadAnimaciones.."]", source, 255, 255, 255, true)
      end
    end
    function Nose(source, command, id)
      local idAnim = tonumber(id)
      local cantidadAnimaciones = #animacionesNose
      if idAnim and animacionesNose[idAnim] then
        local group, animacion = unpack(animacionesNose[idAnim])
        gestionarAnimacion(source, group, animacion)
      else
        gestionarAnimacion(source, nil, nil)
        outputChatBox("#FF0000Uso incorrecto. Usa: /nose [1-"..cantidadAnimaciones.."]", source, 255, 255, 255, true)
      end
    end
    function Quepaso(source, command, id)
      local idAnim = tonumber(id)
      local cantidadAnimaciones = #animacionesQuepaso
      if idAnim and animacionesQuepaso[idAnim] then
        local group, animacion = unpack(animacionesQuepaso[idAnim])
        gestionarAnimacion(source, group, animacion)
      else
        gestionarAnimacion(source, nil, nil)
        outputChatBox("#FF0000Uso incorrecto. Usa: /quepaso [1-"..cantidadAnimaciones.."]", source, 255, 255, 255, true)
      end
    end
    function Rap(source, command, id)
      local idAnim = tonumber(id)
      local cantidadAnimaciones = #animacionesRap
      if idAnim and animacionesRap[idAnim] then
        local group, animacion = unpack(animacionesRap[idAnim])
        gestionarAnimacion(source, group, animacion)
      else
        gestionarAnimacion(source, nil, nil)
        outputChatBox("#FF0000Uso incorrecto. Usa: /rap [1-"..cantidadAnimaciones.."]", source, 255, 255, 255, true)
      end
    end
    function RCP(source, command, id)
      local idAnim = tonumber(id)
      local cantidadAnimaciones = #animacionesRCP
      if idAnim and animacionesRCP[idAnim] then
        local group, animacion = unpack(animacionesRCP[idAnim])
        gestionarAnimacion(source, group, animacion)
      else
        gestionarAnimacion(source, nil, nil)
        outputChatBox("#FF0000Uso incorrecto. Usa: /rcp [1-"..cantidadAnimaciones.."]", source, 255, 255, 255, true)
      end
    end
    function Apuntar(source, command, id)
      local idAnim = tonumber(id)
      local cantidadAnimaciones = #animacionesApuntar
      if idAnim and animacionesApuntar[idAnim] then
        local group, animacion = unpack(animacionesApuntar[idAnim])
        gestionarAnimacion(source, group, animacion)
      else
        gestionarAnimacion(source, nil, nil)
        outputChatBox("#FF0000Uso incorrecto. Usa: /apuntar [1-"..cantidadAnimaciones.."]", source, 255, 255, 255, true)
      end
    end
    function Facepalm(source, command, id)
      local idAnim = tonumber(id)
      local cantidadAnimaciones = #animacionesFacepalm
      if idAnim and animacionesFacepalm[idAnim] then
        local group, animacion = unpack(animacionesFacepalm[idAnim])
        gestionarAnimacion(source, group, animacion)
      else
        gestionarAnimacion(source, nil, nil)
        outputChatBox("#FF0000Uso incorrecto. Usa: /facepalm [1-"..cantidadAnimaciones.."]", source, 255, 255, 255, true)
      end
    end
    function Rascar(source, command, id)
      local idAnim = tonumber(id)
      local cantidadAnimaciones = #animacionesRascar
      if idAnim and animacionesRascar[idAnim] then
        local group, animacion = unpack(animacionesRascar[idAnim])
        gestionarAnimacion(source, group, animacion)
      else
        gestionarAnimacion(source, nil, nil)
        outputChatBox("#FF0000Uso incorrecto. Usa: /rascar [1-"..cantidadAnimaciones.."]", source, 255, 255, 255, true)
      end
    end
    function Buscar(source, command, id)
      local idAnim = tonumber(id)
      local cantidadAnimaciones = #animacionesBuscar
      if idAnim and animacionesBuscar[idAnim] then
        local group, animacion = unpack(animacionesBuscar[idAnim])
        gestionarAnimacion(source, group, animacion)
      else
        gestionarAnimacion(source, nil, nil)
        outputChatBox("#FF0000Uso incorrecto. Usa: /buscar [1-"..cantidadAnimaciones.."]", source, 255, 255, 255, true)
      end
    end
    function Alentar(source, command, id)
      local idAnim = tonumber(id)
      local cantidadAnimaciones = #animacionesAlentar
      if idAnim and animacionesAlentar[idAnim] then
        local group, animacion = unpack(animacionesAlentar[idAnim])
        gestionarAnimacion(source, group, animacion)
      else
        gestionarAnimacion(source, nil, nil)
        outputChatBox("#FF0000Uso incorrecto. Usa: /alentar [1-"..cantidadAnimaciones.."]", source, 255, 255, 255, true)
      end
    end
    function Taichi(source, command, id)
      local idAnim = tonumber(id)
      local cantidadAnimaciones = #animacionesTaichi
      if idAnim and animacionesTaichi[idAnim] then
        local group, animacion = unpack(animacionesTaichi[idAnim])
        gestionarAnimacion(source, group, animacion)
      else
        gestionarAnimacion(source, nil, nil)
        outputChatBox("#FF0000Uso incorrecto. Usa: /taichi [1-"..cantidadAnimaciones.."]", source, 255, 255, 255, true)
      end
    end
    function Mear(source, command, id)
      local idAnim = tonumber(id)
      local cantidadAnimaciones = #animacionesMear
      if idAnim and animacionesMear[idAnim] then
        local group, animacion = unpack(animacionesMear[idAnim])
        gestionarAnimacion(source, group, animacion)
      else
        gestionarAnimacion(source, nil, nil)
        outputChatBox("#FF0000Uso incorrecto. Usa: /mear [1-"..cantidadAnimaciones.."]", source, 255, 255, 255, true)
      end
    end
    function Paja(source, command, id)
      local idAnim = tonumber(id)
      local cantidadAnimaciones = #animacionesPaja
      if idAnim and animacionesPaja[idAnim] then
        local group, animacion = unpack(animacionesPaja[idAnim])
        gestionarAnimacion(source, group, animacion)
      else
        gestionarAnimacion(source, nil, nil)
        outputChatBox("#FF0000Uso incorrecto. Usa: /paja [1-"..cantidadAnimaciones.."]", source, 255, 255, 255, true)
      end
    end
    function Asustado(source, command, id)
      local idAnim = tonumber(id)
      local cantidadAnimaciones = #animacionesAsustado
      if idAnim and animacionesAsustado[idAnim] then
        local group, animacion = unpack(animacionesAsustado[idAnim])
        gestionarAnimacion(source, group, animacion)
      else
        gestionarAnimacion(source, nil, nil)
        outputChatBox("#FF0000Uso incorrecto. Usa: /asustado [1-"..cantidadAnimaciones.."]", source, 255, 255, 255, true)
      end
    end
    function Queteden(source, command, id)
      local idAnim = tonumber(id)
      local cantidadAnimaciones = #animacionesQueteden
      if idAnim and animacionesQueteden[idAnim] then
        local group, animacion = unpack(animacionesQueteden[idAnim])
        gestionarAnimacion(source, group, animacion)
      else
        gestionarAnimacion(source, nil, nil)
        outputChatBox("#FF0000Uso incorrecto. Usa: /queteden [1-"..cantidadAnimaciones.."]", source, 255, 255, 255, true)
      end
    end
    function Caer(source, command, id)
      local idAnim = tonumber(id)
      local cantidadAnimaciones = #animacionesCaer
      if idAnim and animacionesCaer[idAnim] then
        local group, animacion, time, loop, freezeLastFrame = unpack(animacionesCaer[idAnim])
        --iprint("1 - ")
        --iprint(source, group, animacion, time, loop, freezeLastFrame)
        gestionarAnimacion(source, group, animacion, time, loop, freezeLastFrame)
      else
        gestionarAnimacion(source, nil, nil)
        outputChatBox("#FF0000Uso incorrecto. Usa: /caer [1-"..cantidadAnimaciones.."]", source, 255, 255, 255, true)
      end
    end
    function Estirar(source, command, id)
      local idAnim = tonumber(id)
      local cantidadAnimaciones = #animacionesEstirar
      if idAnim and animacionesEstirar[idAnim] then
        local group, animacion = unpack(animacionesEstirar[idAnim])
        gestionarAnimacion(source, group, animacion)
      else
        gestionarAnimacion(source, nil, nil)
        outputChatBox("#FF0000Uso incorrecto. Usa: /estirar [1-"..cantidadAnimaciones.."]", source, 255, 255, 255, true)
      end
    end
    function Trafico(source, command, id)
      local idAnim = tonumber(id)
      local cantidadAnimaciones = #animacionesTrafico
      if idAnim and animacionesTrafico[idAnim] then
        local group, animacion = unpack(animacionesTrafico[idAnim])
        gestionarAnimacion(source, group, animacion)
      else
        gestionarAnimacion(source, nil, nil)
        outputChatBox("#FF0000Uso incorrecto. Usa: /trafico [1-"..cantidadAnimaciones.."]", source, 255, 255, 255, true)
      end
    end
    function Patear(source, command, id)
      local idAnim = tonumber(id)
      local cantidadAnimaciones = #animacionesPatear
      if idAnim and animacionesPatear[idAnim] then
        local group, animacion = unpack(animacionesPatear[idAnim])
        gestionarAnimacion(source, group, animacion)
      else
        gestionarAnimacion(source, nil, nil)
        outputChatBox("#FF0000Uso incorrecto. Usa: /patear [1-"..cantidadAnimaciones.."]", source, 255, 255, 255, true)
      end
    end
    function Reir(source, command, id)
      local idAnim = tonumber(id)
      local cantidadAnimaciones = #animacionesReir
      if idAnim and animacionesReir[idAnim] then
        local group, animacion = unpack(animacionesReir[idAnim])
        gestionarAnimacion(source, group, animacion)
      else
        gestionarAnimacion(source, nil, nil)
        outputChatBox("#FF0000Uso incorrecto. Usa: /reir [1-"..cantidadAnimaciones.."]", source, 255, 255, 255, true)
      end
    end
    function DJ(source, command, id)
      local idAnim = tonumber(id)
      local cantidadAnimaciones = #animacionesDJ
      if idAnim and animacionesDJ[idAnim] then
        local group, animacion = unpack(animacionesDJ[idAnim])
        gestionarAnimacion(source, group, animacion)
      else
        gestionarAnimacion(source, nil, nil)
        outputChatBox("#FF0000Uso incorrecto. Usa: /dj [1-"..cantidadAnimaciones.."]", source, 255, 255, 255, true)
      end
    end
    function Rendirse(source, command, id)
      local idAnim = tonumber(id)
      local cantidadAnimaciones = #animacionesRendirse
      if idAnim and animacionesRendirse[idAnim] then
        local group, animacion = unpack(animacionesRendirse[idAnim])
        gestionarAnimacion(source, group, animacion)
      else
        gestionarAnimacion(source, nil, nil)
        outputChatBox("#FF0000Uso incorrecto. Usa: /rendirse [1-"..cantidadAnimaciones.."]", source, 255, 255, 255, true)
      end
    end
    function Strip(source, command, id)
      local idAnim = tonumber(id)
      local cantidadAnimaciones = #animacionesStrip
      if idAnim and animacionesStrip[idAnim] then
        local group, animacion = unpack(animacionesStrip[idAnim])
        gestionarAnimacion(source, group, animacion)
      else
        gestionarAnimacion(source, nil, nil)
        outputChatBox("#FF0000Uso incorrecto. Usa: /strip [1-"..cantidadAnimaciones.."]", source, 255, 255, 255, true)
      end
    end
    function Tirarse(source, command, id)
      local idAnim = tonumber(id)
      local cantidadAnimaciones = #animacionesTirarse
      if idAnim and animacionesTirarse[idAnim] then
        local group, animacion = unpack(animacionesTirarse[idAnim])
        gestionarAnimacion(source, group, animacion)
      else
        gestionarAnimacion(source, nil, nil)
        outputChatBox("#FF0000Uso incorrecto. Usa: /tirarse [1-"..cantidadAnimaciones.."]", source, 255, 255, 255, true)
      end
    end
    function detenerAnimacionPorTecla(player)
      if animacionesJugadores[player] then
        
          if animacionesJugadores[player][1] == "shop" and animacionesJugadores[player][2] == "shp_rob_handsup" then
              exports["MR1_Inicio"]:setValue(player, "Rendirse", nil)
          end
          animacionesJugadores[player] = nil
          setPedAnimation(player, false)
          triggerClientEvent(player, "syncAnimacion", player, false)
      end
    end
    function bindearTeclaEspacioParaJugadores()
      for _, player in ipairs(getElementsByType("player")) do
          bindKey(player, "space", "down", detenerAnimacionPorTecla)
      end
    end
-- Eventos y Handlers
    addEventHandler("onResourceStart", resourceRoot, bindearTeclaEspacioParaJugadores)
    function detenerAnimaciones()
      -- Recorrer todos los jugadores en el servidor
      for _, player in ipairs(getElementsByType("player")) do
          -- Detener la animación del jugador
          setPedAnimation(player, false)
      end
      --outputDebugString("[Servidor] Animaciones detenidas para todos los jugadores.")
  end
  
  -- Llamar a la función cuando el recurso se detenga
    addEventHandler("onResourceStop", resourceRoot, detenerAnimaciones)
    addEvent("detenerAnimacion", true)
    addEventHandler("detenerAnimacion", root, function()
        if animacionesJugadores[client] then
            local animacion = animacionesJugadores[client]
            animacionesJugadores[client] = nil
            triggerClientEvent(client, "syncAnimacion", client, false)
        end
    end)
    addCommandHandler("sentarse", Sentarse)
    addCommandHandler("apoyarse", Apoyarse)
    addCommandHandler("beber", Beber)
    addCommandHandler("reparar", Reparar)
    addCommandHandler("ctm", CTM)
    addCommandHandler("camara", Camara)
    addCommandHandler("vendedor", Vendedor)
    addCommandHandler("perdedor", Perdedor)
    addCommandHandler("tocar", Tocar)
    addCommandHandler("tomar", Tomar)
    addCommandHandler("pose", Pose)
    addCommandHandler("cruzarbrazos", CruzarBrazos)
    addCommandHandler("esperar", Esperar)
    addCommandHandler("pensar", Pensar)
    addCommandHandler("reloj", Reloj)
    addCommandHandler("bate", Bate)
    addCommandHandler("dormir", Dormir)
    addCommandHandler("herido", Herido)
    addCommandHandler("baile", Baile)
    addCommandHandler("guardia", Guardia)
    addCommandHandler("cansado", Cansado)
    addCommandHandler("comer", Comer)
    addCommandHandler("vomitar", Vomitar)
    addCommandHandler("asco", Asco)
    addCommandHandler("festejo", Festejo)
    addCommandHandler("fumar", Fumar)
    addCommandHandler("no", No)
    addCommandHandler("si", Si)
    addCommandHandler("gang", Gang)
    addCommandHandler("llorar", Llorar)
    addCommandHandler("pararse", Pararse)
    addCommandHandler("escribir", Escribir)
    addCommandHandler("saludar", Saludar)
    addCommandHandler("nose", Nose)
    addCommandHandler("quepaso", Quepaso)
    addCommandHandler("rap", Rap)
    addCommandHandler("rcp", RCP)
    addCommandHandler("apuntar", Apuntar)
    addCommandHandler("facepalm", Facepalm)
    addCommandHandler("rascar", Rascar)
    addCommandHandler("buscar", Buscar)
    addCommandHandler("alentar", Alentar)
    addCommandHandler("taichi", Taichi)
    addCommandHandler("mear", Mear)
    addCommandHandler("paja", Paja)
    addCommandHandler("asustado", Asustado)
    addCommandHandler("queteden", Queteden)
    addCommandHandler("caer", Caer)
    addCommandHandler("estirar", Estirar)
    addCommandHandler("trafico", Trafico)
    addCommandHandler("patear", Patear)
    addCommandHandler("reir", Reir)
    addCommandHandler("dj", DJ)
    addCommandHandler("rendirse", Rendirse)
    addCommandHandler("strip", Strip)
    addCommandHandler("tirarse", Tirarse)
    addEventHandler("onPlayerJoin", root, function()
      bindKey(source, "space", "down", detenerAnimacionPorTecla)
    end)
-- Inicialización
-- Por ejemplo, spawnear vehículos, etc.