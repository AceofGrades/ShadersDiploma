Shader "Lesson/Normal Albedo"
{
    // Public properties seen on material
    Properties
	{
		_Texture("Texture",2D) = "black"{}
		// Our Variable name is _Texture
		// Our Display name is Texture
		// It is of type 2D and the default untextured colour is black
		_NormalMap("Normal",2D) = "bump"{}
		// Uses RGB colour value to create XYZ depth to the material
		// Bump tells Unity that this material needs to be marked as Normal map for correct usage
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
		sampler2D _NormalMap;
		// Connects _NormalMap Variable in Properties to _NormalMap Variable in CG
		struct Input
		{
			float2 uv_Texture;
			// This is in reference to our UV map of our model
			// UV maps are the wrapping of a model
			// "U" and "V" denote the axes of the 2D texture becaue "X", "Y", and "Z" are already used to denote the axes of a 3D object in model space
			float2 uv_NormalMap;
			// UV map link to _NormalMap image
		};
		void MainColour(Input IN, inout SurfaceOutput o)
		{
			o.Albedo = tex2D(_Texture, IN.uv_Texture).rgb;
			// Albedo is in reference to the surface Image and RGB of our model
			// RGB = Red, Green, Blue
			// Set the models surface to the colour of Texture2D and matching Texture to the model's UV mapping
			o.Normal = UnpackNormal(tex2D(_NormalMap, IN.uv_NormalMap));
			// _NormalMap is in reference to bump map in Properties
			// UnpackNormal Required due to file being compressed
			// Need to decompress to get true value from image
			// Bump maps are visible when light reflects off
			// Light is bounced off at angles according to images RGB or XYZ values
			// This creates the illusion of depth
		}
		ENDCG // This is the end of our C for Graphics Language
	}
	FallBack "Diffuse" // IF all else fails, use standard shader(Lambert and Texture)
}
