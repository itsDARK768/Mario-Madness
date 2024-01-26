package modules.fixedshaders;

class Bloom extends TemplateShader {
    private var fragmentSource:String = '#pragma header

    // GAUSSIAN BLUR SETTINGS
  	uniform float dim;
    uniform float Directions;
    uniform float Quality; 
    uniform float Size; 

	void main(void)
	{ 
		vec2 uv = openfl_TextureCoordv.xy ;

		float Pi = 6.28318530718; // Pi*2

		vec4 Color = texture2D( bitmap, uv);
		
		for(float d=0.0; d<Pi; d+=Pi/Directions){
			for(float i=1.0/Quality; i<=1.0; i+=1.0/Quality){

				float ex = (cos(d)*Size*i)/openfl_TextureSize.x;
				float why = (sin(d)*Size*i)/openfl_TextureSize.y;
				Color += flixel_texture2D( bitmap, uv+vec2(ex,why));	
			}
		}
		
		Color /= (dim * Quality) * Directions - 15.0;
		vec4 bloom =  (flixel_texture2D( bitmap, uv)/ dim)+Color;

		gl_FragColor = bloom;

	}';

    public function new() {
        super(fragmentSource);

        data.Size.value = [18.0];
		data.Quality.value = [8.0];
		data.dim.value = [2.0];
		data.Directions.value = [16.0];
    }
}