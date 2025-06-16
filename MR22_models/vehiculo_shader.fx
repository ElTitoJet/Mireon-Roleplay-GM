texture gTexture;

technique Replace {
    pass P0 {
        Texture[0] = gTexture;
    }
}
