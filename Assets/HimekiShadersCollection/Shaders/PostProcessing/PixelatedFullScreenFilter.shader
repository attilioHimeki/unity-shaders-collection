Shader "HimekiCollection/PostProcessing/PixelatedFullScreenFilter"
{

    Properties
	{
		[HideInInspector] _MainTex ("Texture", 2D) = "white" {}
		_Intensity ("Intensity", Range(0, 0.1)) = 0.1
	}
	SubShader
	{
		Cull Off ZWrite Off ZTest Always

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			sampler2D _MainTex;
			fixed _Intensity;

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

			fixed4 frag (v2f i) : COLOR 
			{
				if(_Intensity > 0)
				{
					i.uv /= _Intensity;
					i.uv = round(i.uv);
					i.uv *= _Intensity;
				}
				return tex2D(_MainTex, i.uv);
			}
			ENDCG
		}
	}
}