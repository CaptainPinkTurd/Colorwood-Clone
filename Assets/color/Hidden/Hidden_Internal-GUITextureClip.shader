Shader "Hidden/Internal-GUITextureClip"
{
  Properties
  {
    _MainTex ("Texture", any) = "white" {}
  }
  SubShader
  {
    Tags
    { 
    }
    Pass // ind: 1, name: 
    {
      Tags
      { 
      }
      ZTest Always
      ZWrite Off
      Cull Off
      Blend SrcAlpha OneMinusSrcAlpha, One One
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      
      
      uniform float4 unity_ObjectToWorld[4];
      
      uniform float4 unity_MatrixV[4];
      
      uniform float4 unity_MatrixVP[4];
      
      uniform float4 _MainTex_ST;
      
      uniform float4 unity_GUIClipTextureMatrix[4];
      
      uniform int _ManualTex2SRGB;
      
      uniform sampler2D _MainTex;
      
      uniform sampler2D _GUIClipTexture;
      
      
      
      struct appdata_t
      {
          
          float4 vertex : POSITION0;
          
          float4 color : COLOR0;
          
          float2 texcoord : TEXCOORD0;
      
      };
      
      
      struct OUT_Data_Vert
      {
          
          float4 color : COLOR0;
          
          float2 texcoord : TEXCOORD0;
          
          float2 texcoord1 : TEXCOORD1;
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float4 color : COLOR0;
          
          float2 texcoord : TEXCOORD0;
          
          float2 texcoord1 : TEXCOORD1;
      
      };
      
      
      struct OUT_Data_Frag
      {
          
          float4 color : SV_Target0;
      
      };
      
      
      float4 u_xlat0;
      
      float4 u_xlat1;
      
      float2 u_xlat2;
      
      OUT_Data_Vert vert(appdata_t in_v)
      {
          
          u_xlat0 = in_v.vertex.yyyy * unity_ObjectToWorld[1];
          
          u_xlat0 = unity_ObjectToWorld[0] * in_v.vertex.xxxx + u_xlat0;
          
          u_xlat0 = unity_ObjectToWorld[2] * in_v.vertex.zzzz + u_xlat0;
          
          u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
          
          u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
          
          u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
          
          u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
          
          out_v.vertex = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
          
          out_v.color = in_v.color;
          
          u_xlat1.xy = u_xlat0.yy * unity_MatrixV[1].xy;
          
          u_xlat0.xy = unity_MatrixV[0].xy * u_xlat0.xx + u_xlat1.xy;
          
          u_xlat0.xy = unity_MatrixV[2].xy * u_xlat0.zz + u_xlat0.xy;
          
          u_xlat0.xy = unity_MatrixV[3].xy * u_xlat0.ww + u_xlat0.xy;
          
          u_xlat2.xy = u_xlat0.yy * unity_GUIClipTextureMatrix[1].xy;
          
          u_xlat0.xy = unity_GUIClipTextureMatrix[0].xy * u_xlat0.xx + u_xlat2.xy;
          
          out_v.texcoord1.xy = u_xlat0.xy + unity_GUIClipTextureMatrix[3].xy;
          
          out_v.texcoord.xy = in_v.texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float u_xlat0_d;
      
      float4 u_xlat16_0;
      
      float3 u_xlat16_1;
      
      float3 u_xlat2_d;
      
      float u_xlat16_10;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat16_0 = texture(_MainTex, in_f.texcoord.xy);
          
          u_xlat16_1.xyz = max(u_xlat16_0.xyz, float3(0.0, 0.0, 0.0));
          
          u_xlat2_d.xyz = log2(u_xlat16_1.xyz);
          
          u_xlat2_d.xyz = u_xlat2_d.xyz * float3(0.416666657, 0.416666657, 0.416666657);
          
          u_xlat2_d.xyz = exp2(u_xlat2_d.xyz);
          
          u_xlat2_d.xyz = u_xlat2_d.xyz * float3(1.05499995, 1.05499995, 1.05499995) + float3(-0.0549999997, -0.0549999997, -0.0549999997);
          
          u_xlat2_d.xyz = max(u_xlat2_d.xyz, float3(0.0, 0.0, 0.0));
          
          u_xlat16_1.xyz = (_ManualTex2SRGB != 0) ? u_xlat2_d.xyz : u_xlat16_0.xyz;
          
          u_xlat16_10 = u_xlat16_0.w * in_f.color.w;
          
          out_f.color.xyz = u_xlat16_1.xyz * in_f.color.xyz;
          
          u_xlat16_0.x = texture(_GUIClipTexture, in_f.texcoord1.xy).w;
          
          u_xlat0_d = u_xlat16_0.x * u_xlat16_10;
          
          out_f.color.w = u_xlat0_d;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
  }
  SubShader
  {
    Tags
    { 
    }
    Pass // ind: 1, name: 
    {
      Tags
      { 
      }
      ZTest Always
      ZWrite Off
      Cull Off
      Blend SrcAlpha OneMinusSrcAlpha
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      
      
      uniform float4 unity_ObjectToWorld[4];
      
      uniform float4 unity_MatrixV[4];
      
      uniform float4 unity_MatrixVP[4];
      
      uniform float4 _MainTex_ST;
      
      uniform float4 unity_GUIClipTextureMatrix[4];
      
      uniform int _ManualTex2SRGB;
      
      uniform sampler2D _MainTex;
      
      uniform sampler2D _GUIClipTexture;
      
      
      
      struct appdata_t
      {
          
          float4 vertex : POSITION0;
          
          float4 color : COLOR0;
          
          float2 texcoord : TEXCOORD0;
      
      };
      
      
      struct OUT_Data_Vert
      {
          
          float4 color : COLOR0;
          
          float2 texcoord : TEXCOORD0;
          
          float2 texcoord1 : TEXCOORD1;
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float4 color : COLOR0;
          
          float2 texcoord : TEXCOORD0;
          
          float2 texcoord1 : TEXCOORD1;
      
      };
      
      
      struct OUT_Data_Frag
      {
          
          float4 color : SV_Target0;
      
      };
      
      
      float4 u_xlat0;
      
      float4 u_xlat1;
      
      float2 u_xlat2;
      
      OUT_Data_Vert vert(appdata_t in_v)
      {
          
          u_xlat0 = in_v.vertex.yyyy * unity_ObjectToWorld[1];
          
          u_xlat0 = unity_ObjectToWorld[0] * in_v.vertex.xxxx + u_xlat0;
          
          u_xlat0 = unity_ObjectToWorld[2] * in_v.vertex.zzzz + u_xlat0;
          
          u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
          
          u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
          
          u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
          
          u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
          
          out_v.vertex = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
          
          out_v.color = in_v.color;
          
          u_xlat1.xy = u_xlat0.yy * unity_MatrixV[1].xy;
          
          u_xlat0.xy = unity_MatrixV[0].xy * u_xlat0.xx + u_xlat1.xy;
          
          u_xlat0.xy = unity_MatrixV[2].xy * u_xlat0.zz + u_xlat0.xy;
          
          u_xlat0.xy = unity_MatrixV[3].xy * u_xlat0.ww + u_xlat0.xy;
          
          u_xlat2.xy = u_xlat0.yy * unity_GUIClipTextureMatrix[1].xy;
          
          u_xlat0.xy = unity_GUIClipTextureMatrix[0].xy * u_xlat0.xx + u_xlat2.xy;
          
          out_v.texcoord1.xy = u_xlat0.xy + unity_GUIClipTextureMatrix[3].xy;
          
          out_v.texcoord.xy = in_v.texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float u_xlat0_d;
      
      float4 u_xlat16_0;
      
      float3 u_xlat16_1;
      
      float3 u_xlat2_d;
      
      float u_xlat16_10;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat16_0 = texture(_MainTex, in_f.texcoord.xy);
          
          u_xlat16_1.xyz = max(u_xlat16_0.xyz, float3(0.0, 0.0, 0.0));
          
          u_xlat2_d.xyz = log2(u_xlat16_1.xyz);
          
          u_xlat2_d.xyz = u_xlat2_d.xyz * float3(0.416666657, 0.416666657, 0.416666657);
          
          u_xlat2_d.xyz = exp2(u_xlat2_d.xyz);
          
          u_xlat2_d.xyz = u_xlat2_d.xyz * float3(1.05499995, 1.05499995, 1.05499995) + float3(-0.0549999997, -0.0549999997, -0.0549999997);
          
          u_xlat2_d.xyz = max(u_xlat2_d.xyz, float3(0.0, 0.0, 0.0));
          
          u_xlat16_1.xyz = (_ManualTex2SRGB != 0) ? u_xlat2_d.xyz : u_xlat16_0.xyz;
          
          u_xlat16_10 = u_xlat16_0.w * in_f.color.w;
          
          out_f.color.xyz = u_xlat16_1.xyz * in_f.color.xyz;
          
          u_xlat16_0.x = texture(_GUIClipTexture, in_f.texcoord1.xy).w;
          
          u_xlat0_d = u_xlat16_0.x * u_xlat16_10;
          
          out_f.color.w = u_xlat0_d;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
