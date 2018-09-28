Shader "HimekiCollection/Unlit/Mask/TransparentMaskUnlit"
{
	Properties
	{
		 _Color ("Color", Color) = (1, 0, 0, 0.8)
	}
	SubShader
	{
		Tags { "RenderType"="Transparent" 
				"Queue" = "Geometry-1" }

		Blend SrcAlpha OneMinusSrcAlpha
		ZWrite Off

		Stencil {
			Ref 1
			Comp Always
			Pass Replace
		}

		Pass
		{
		
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"

			fixed4 _Color;

			struct appdata
			{
				float4 vertex : POSITION;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
			};
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				return _Color;
			}
			ENDCG
		}
	}
}
