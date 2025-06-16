
local serialesPermitidos = {

    -- 10 - OWNER
        "BACC41FBD43F133DF257474D622F8494", -- ElTitoJet
    -- 9 - ADM. STAFF
        "19A3EED0540DC411F9015005E2D7D442", -- Tesla        <@704492684819038228>
    -- 8 - ADM. FACCIONES
        "DC6F91643E37A071224190E48FCF0F71", -- Bleur         <@612681336112545812>
        "2620B67D81AF23F4FE30EA4E2F05EE42", -- Patrick       <@433065416496119820>
    -- 7 - ADM. FAMILIAS
        "6A875C8043DF482532E530E02AA5E9B2", -- Micha        <@607690604801163296>
        "C123F74860396C5AAB3F6A031D715DA3", -- Lexa         <@776537726161387570>
    -- 6 - ADM. Tickets
        "16257F28337F13CE2E0606096150B412", -- Skuishy      <@795803505746640937>
    -- 5 - S. SOPORTE
    -- 4 - SOPORTE
        "F22E27EBB2B40414CBD424CB71DF0BA1", -- Hotson       <@808489096363507984>
    -- 3 - SOPORTE A PRUEBA
        "5FB4E78097EEAF3E31FE9EA101F264A1", -- Jardon       <@1190530657722581022>
        "BE55B9EFB3ECF1814F440723A1F4E971", -- Canjua       <@561648231809810433>
        "89EE3A354506021D07E2269EE71B94A2", -- Flogus       <@1084436762522288138>
        "96A58A65D150F11760C84BF9B2529844", -- EngCent      <@906076393656422400>
        "5F85B9FA1F9552D22F1AEE0EB572B343", -- Frankie      <@591461835207606272>
        "1399D3901EC2B280B1EB7D6EDD7BABB4", -- Dante        <@705503914061201420>
        "2BD9ECC64BD7E1D08F60D1AE1EF0C0F3", -- Matees       <@256666849167671296>
    -- EMBAJADORES
        -- SCRIPTER
            "AC8C034F456C9D1371D2C2F971506534", -- ClawSuit     <@544286769047142406>
        -- DISEÑADORES
            "16257F28337F13CE2E0606096150B412", -- Skuishy      <@795803505746640937>
        -- MAPPER
            "1BB6DDBC79E7593D593D1B2DE5860643", -- frechox      <@913106895919788062>
        -- TESTER
            "D6EB26AF13DFFE07745A123E0B75FEA4", -- Diegoso      <@273518246810877952>
        -- AYUDANTE
        -- DONADORES
            "DFF7C9AA395AB8D0287936EB83819C02", -- Antar        <@284440095032082432>
            "99EBCC26B0BB1D3A7133EE62109A0A52", "A3AA3840E96D6E6852344205128D8B94", -- Suriel       <@469344591896903681>
            "B2FEBD7DF28D6387C5CB97783D3204F4", -- Robsito      <@441570670770651136>
            "C11C6111E1A6762C1FFAF6D10E094814", -- radeem17     <@1101335745601482782>
            "9DCF2B9C75C7BDC53300317B08DE56E3", -- byflypper3114    <@523520261492965387>
        -- CREADORES
            "DDB75F84BF5317379B53BB46A03A8E41", --1s            <@747697643165188096>
            "88B9A32EA1E13B0302D50EB43804E8E4", -- KAIIO        <@496748508481716224>
}

function isSerialPermitido(serial)
    for _, serialPermitido in ipairs(serialesPermitidos) do
        if serial == serialPermitido then
            return true
        end
    end
    return false
end

addEventHandler("onPlayerConnect", root, function(playerNick, playerIP, playerUsername, playerSerial, playerVersionNumber, playerVersionString)
    -- Verificar si el serial del jugador está en la lista de seriales permitidos
    if not isSerialPermitido(playerSerial) then
        -- Si el serial no está en la lista, se rechaza la conexión del jugador
        cancelEvent(true, "Whitelist activa. \nhttps://discord.gg/dvUHAxX22b")
    end
end)
