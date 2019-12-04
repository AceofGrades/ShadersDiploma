// This section allows for easy sorting of our shader in the shader menu
Shader "Lesson/Albedo"
{
	// Public properties seen on material
    Properties
	{
		_Texture("Texture",2D) = "black"{}
		// Our Variable name is _Texture
		// Our Display name is Texture
		// It is of type 2D and the default untextured colour is black
	}
	// You can have multiple subshaders
	// These run at different GPU levels on different platforms
	SubShader
	{
		Tags
		{
			"RenderType" = "Opaque"
			// Tags are key-value pairs
			// Inside a subshader, tags are used to determine rendering order and other parameters of a subshader

			// RenderType tag categorises shaders into several predefined groups
		}
		CGPROGRAM // This is the start of our C for Graphics Language
		#pragma surface MainColour Lambert
		// The surface of our model is affected by the mainColour Function
		// The material type is Lambert, which is a flat material that has no specular (Shiny spots)
		sampler2D _Texture;
		// This connects our _Texture Variable that is in the Properties section to our 2D _Texture variable in CG
		struct Input
		{
			float2 uv_Texture;
			// This is in reference to our UV map of our model
			// UV maps are the wrapping of a model
			// "U" and "V" denote the axes of the 2D texture becaue "X", "Y", and "Z" are already used to denote the axes of a 3D object in model space
		};
		void MainColour(Input IN, inout SurfaceOutput o)
		{
			o.Albedo = tex2D(_Texture, IN.uv_Texture).rgb;
			// Albedo is in reference to the surface Image and RGB of our model
			// RGB = Red, Green, Blue
			// Set the models surface to the colour of Texture2D and matching Texture to the model's UV mapping
		}
		ENDCG // This is the end of our C for Graphics Language
	}
	FallBack "Diffuse" // IF all else fails, use standard shader(Lambert and Texture)
}
