Shader "HimekiCollection/Unlit/SeeThroughWithTransparencyUnlit" 
{
    Properties 
	{
        _MainTex ("Base (RGB)", 2D) = "white" {}
        _SeeThroughColor ("See Through Color", Color) = (1, 0, 0, 0.8)
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
	fixed4 _SeeThroughColor;

	v2f vert (appdata v)
	{
		v2f o;
		o.vertex = UnityObjectToClipPos(v.vertex);
		o.uv = TRANSFORM_TEX(v.uv, _MainTex);
		return o;
	}

	ENDCG
    SubShader 
	{

        Pass 
		{
			Tags {"RenderType"="Opaque"}
            ZWrite On
            ZTest Less

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			fixed4 frag (v2f i) : SV_Target
			{
				fixed4 col = tex2D(_MainTex, i.uv);
				return col;
			}

            ENDCG
        }
		
        Pass 
		{
			Tags {"RenderType"="Transparent"}
            ZWrite Off
			Blend SrcAlpha OneMinusSrcAlpha
			ZTest Greater     
            
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			fixed4 frag (v2f i) : SV_Target
			{
				return _SeeThroughColor;
			}
            ENDCG
        }
    }

}