addEventHandler ( "onClientResourceStart", resourceRoot,
	function ()
        -- SKIN FEMENINA 281
        engineImportTXD ( engineLoadTXD ( "SKINS/sfpd1.txd", 281 ), 281 );
        engineReplaceModel ( engineLoadDFF ( "SKINS/sfpd1.dff", 281 ), 281 );

        -- CHARLIE 
        engineImportTXD (engineLoadTXD("Vehiculos/copcarsf.txd", 598), 598)
        engineReplaceModel (engineLoadDFF("Vehiculos/copcarsf.dff", 598), 598)
        engineImportTXD (engineLoadTXD("Vehiculos/copcarvg.txd", 597), 597)
        engineReplaceModel (engineLoadDFF("Vehiculos/copcarvg.dff", 597), 597)

    end
);