Shader "HimekiCollection/Unlit/SolidOutlineUnlit"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_OutlineColor ("Outline Color", Color) = (1.0, 0, 0, 1)
		_OutlineThickness ("Outline Thickness", Range (0, 0.4)) = 0.1
	}

	CGINCLUDE
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
	
	sampler2D _MainTex;
	float4 _MainTex_ST;
	fixed4 _OutlineColor;
	fixed _OutlineThickness;

	ENDCG

	SubShader
	{
		Tags { "RenderType"="Opaque"
				"DisableBatching"="True" }
				
        Blend SrcAlpha OneMinusSrcAlpha

		Pass
		{
			Cull Front

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			v2f vert (appdata v)
			{
				v2f o;

				float3 normal= normalize(v.vertex.xyz)*_OutlineThickness;
				v.vertex.xyz += normal;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				return _OutlineColor;
			}
			ENDCG
		}

		Pass
		{
			Cull Back
			
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				fixed4 col = tex2D(_MainTex, i.uv);
				return col;
			}
			ENDCG
		}
	}
}
