Shader "Custom/Outloine"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
		_Color ("Color", Color) = (0, 0, 0, 1)
		_Color2 ("Color 2", Color) = (1, 1, 1, 1)
    }
    SubShader
    {
         ZWrite Off ZTest Always

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            sampler2D _MainTex;
			float4 _MainTex_TexelSize;
			sampler2D _CameraDepthTexture;
			sampler2D _DEEEPTH;
			float4 _Color;
			float4 _Color2;

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 col = tex2D(_MainTex, i.uv);
				float depth = Linear01Depth(tex2D(_CameraDepthTexture, i.uv)) * _ProjectionParams.z;
				float deeepth = Linear01Depth(tex2D(_DEEEPTH, i.uv)) * _ProjectionParams.z;

				float outloooine;

                for (float x = -2; x < 2; x++) {
					for (float y = 0; y < 2; y++) {
						float d = Linear01Depth(tex2D(_CameraDepthTexture, i.uv + _MainTex_TexelSize.xy * float2(x, y))) * _ProjectionParams.z;
						float d2 = Linear01Depth(tex2D(_CameraDepthTexture, i.uv - _MainTex_TexelSize.xy * float2(x, y))) * _ProjectionParams.z;
						outloooine += depth * 2 - d - d2;
					}
				}

				outloooine /= depth;
				outloooine *= 100;
				outloooine = clamp(outloooine, 0, 1);

                return lerp(_Color, _Color2, outloooine);
            }
            ENDCG
        }
    }
}
