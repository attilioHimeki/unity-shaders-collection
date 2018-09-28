Shader "HimekiCollection/Distortion/MagnifyingDistortion"
{
    Properties{
        _Intensity("Magnification Intensity", Range(1, 10)) = 2
    }

    CGINCLUDE
	#include "UnityCG.cginc"
	
	struct appdata
    {
        float4 vertex : POSITION;
    };

    struct v2f
    {
        float4 grabPos : TEXCOORD0;
        float4 vertex : SV_POSITION;
    };
    
	ENDCG

    SubShader
    {
        Tags {"Queue"="Transparent" 
                "RenderType"="Transparent"}
        ZTest Off
        ZWrite Off
        Blend One Zero

        GrabPass
        {
            "_GrabTexture"
        }

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            sampler2D _GrabTexture;
            fixed _Intensity;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);

                fixed4 vertexPos = ComputeGrabScreenPos(o.vertex);
                fixed4 center = ComputeGrabScreenPos(UnityObjectToClipPos(fixed4(0, 0, 0, 1)));
				fixed4 diff =  (vertexPos - center) / _Intensity;
				o.grabPos = center + diff;

                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 col = tex2Dproj(_GrabTexture, i.grabPos);
                return col;
            }
            ENDCG
        }
    }
}