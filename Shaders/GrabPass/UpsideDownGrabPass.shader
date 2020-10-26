﻿Shader "Custom/GrabPass/GrabPassUpsideDown"
{
    SubShader
    {
        Tags { "Queue" = "Transparent" }
 
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
 
            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };
 
            struct v2f
            {
                float4 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };
 
            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = ComputeGrabScreenPos(float4(o.vertex.x, -o.vertex.y, o.vertex.z, o.vertex.w));
                return o;
            }
 
            sampler2D _GrabTexture;
 
            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 col = tex2Dproj(_GrabTexture,float4(i.uv.x,i.uv.y,i.uv.z,i.uv.w));
                col.r = 0;
                return col;
            }
            ENDCG
        }
    }
}