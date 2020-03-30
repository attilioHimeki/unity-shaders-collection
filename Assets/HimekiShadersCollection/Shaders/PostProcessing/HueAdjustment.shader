Shader "HimekiCollection/PostProcessing/HueAdjustment"
{
	Properties
	{
		[HideInInspector] _MainTex ("Texture", 2D) = "white" {}
		_IntensityR ("Intensity R", Range(0, 2)) = 1
		_IntensityG ("Intensity G", Range(0, 2)) = 1
		_IntensityB ("Intensity B", Range(0, 2)) = 1
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
			fixed _IntensityR;
			fixed _IntensityG;
			fixed _IntensityB;

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

			fixed4 frag (v2f i) : SV_Target
			{
				fixed4 col = tex2D(_MainTex, i.uv);
				col.r *= _IntensityR;
				col.g *= _IntensityG;
				col.b *= _IntensityB;
				return col;
			}
			ENDCG
		}
	}
}
