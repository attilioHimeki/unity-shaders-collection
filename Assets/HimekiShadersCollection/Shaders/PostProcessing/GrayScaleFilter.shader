Shader "HimekiCollection/PostProcessing/GrayScaleFilter"
{
    Properties
	{
		[HideInInspector] _MainTex ("Texture", 2D) = "white" {}
		_Saturation ("Saturation", Range(0, 1)) = 1
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
			fixed _Saturation;

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

                fixed3 intensity = dot(col.rgb, float3(0.299,0.587,0.114));
                col.rgb = lerp(intensity, col.rgb, _Saturation);
				
				return col;
			}
			ENDCG
		}
	}
}