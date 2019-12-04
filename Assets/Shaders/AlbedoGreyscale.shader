Shader "Lesson/Albedo Greyscale"
{
    // Public properties seen on material
    Properties
	{
		_MainTex ("Albedo(RGB)", 2D) = "white"{}
		_EffectAmount ("EffectAmount", Range(0,1)) = 1.0
	}
	SubShader
	{
		Tags
		{
			"RenderType" = "Transparent" "IgnoreObjector" = "True" "Queue" = "Transparent"
		}
		CGPROGRAM // This is the start of our C for Graphics Language
		#pragma surface ImageTransparentGreyScale Lambert alpha
		sampler2D _MainTex;
		uniform float _EffectAmount;

		struct Input
		{
			float2 uv_MainTex;
		};
		
		void ImageTransparentGreyScale(Input IN, inout SurfaceOutput o)
		{
			half4 c = tex2D(_MainTex, IN.uv_MainTex);
			o.Albedo = lerp(c.rgb, dot(c.rgb, float3(0.3,0.59,0.11)), _EffectAmount);
			o.Alpha = c.a;
		}
		ENDCG // This is the end of our C for Graphics Language
	}
	FallBack "Transparent/VertexLit"
}
