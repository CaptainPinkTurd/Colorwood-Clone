Shader "Hidden/Internal-UIRAtlasBlitCopy"
{
  Properties
  {
    _MainTex0 ("Texture", any) = "" {}
    _MainTex1 ("Texture", any) = "" {}
    _MainTex2 ("Texture", any) = "" {}
    _MainTex3 ("Texture", any) = "" {}
    _MainTex4 ("Texture", any) = "" {}
    _MainTex5 ("Texture", any) = "" {}
    _MainTex6 ("Texture", any) = "" {}
    _MainTex7 ("Texture", any) = "" {}
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
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      
      
      uniform float4 unity_ObjectToWorld[4];
      
      uniform float4 unity_MatrixVP[4];
      
      uniform float4 _MainTex0_ST;
      
      uniform float4 _MainTex1_ST;
      
      uniform float4 _MainTex2_ST;
      
      uniform float4 _MainTex3_ST;
      
      uniform float4 _MainTex4_ST;
      
      uniform float4 _MainTex5_ST;
      
      uniform float4 _MainTex6_ST;
      
      uniform float4 _MainTex7_ST;
      
      uniform sampler2D _MainTex0;
      
      uniform sampler2D _MainTex1;
      
      uniform sampler2D _MainTex2;
      
      uniform sampler2D _MainTex3;
      
      uniform sampler2D _MainTex4;
      
      uniform sampler2D _MainTex5;
      
      uniform sampler2D _MainTex6;
      
      uniform sampler2D _MainTex7;
      
      
      
      struct appdata_t
      {
          
          float4 vertex : POSITION0;
          
          float3 texcoord : TEXCOORD0;
          
          float4 color : COLOR0;
      
      };
      
      
      struct OUT_Data_Vert
      {
          
          float3 texcoord : TEXCOORD0;
          
          float4 color : COLOR0;
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float3 texcoord : TEXCOORD0;
          
          float4 color : COLOR0;
      
      };
      
      
      struct OUT_Data_Frag
      {
          
          float4 color : SV_Target0;
      
      };
      
      
      float4 u_xlat0;
      
      uint u_xlatu0;
      
      float4 u_xlat1;
      
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
          
          u_xlatu0 = uint(in_v.texcoord.z);
          
          switch(int(u_xlatu0))
              {
              
              case 0:
              u_xlat0.xy = in_v.texcoord.xy * _MainTex0_ST.xy + _MainTex0_ST.zw;
              
              break;
              
              case 1:
              u_xlat0.xy = in_v.texcoord.xy * _MainTex1_ST.xy + _MainTex1_ST.zw;
              
              break;
              
              case 2:
              u_xlat0.xy = in_v.texcoord.xy * _MainTex2_ST.xy + _MainTex2_ST.zw;
              
              break;
              
              case 3:
              u_xlat0.xy = in_v.texcoord.xy * _MainTex3_ST.xy + _MainTex3_ST.zw;
              
              break;
              
              case 4:
              u_xlat0.xy = in_v.texcoord.xy * _MainTex4_ST.xy + _MainTex4_ST.zw;
              
              break;
              
              case 5:
              u_xlat0.xy = in_v.texcoord.xy * _MainTex5_ST.xy + _MainTex5_ST.zw;
              
              break;
              
              case 6:
              u_xlat0.xy = in_v.texcoord.xy * _MainTex6_ST.xy + _MainTex6_ST.zw;
              
              break;
              
              case 7:
              u_xlat0.xy = in_v.texcoord.xy * _MainTex7_ST.xy + _MainTex7_ST.zw;
              
              break;
              
              default:
              u_xlat0.x = float(0.0);
              
              u_xlat0.y = float(0.0);
              
              break;
      
      }
          
          out_v.texcoord.xy = u_xlat0.xy;
          
          out_v.color = in_v.color;
          
          out_v.texcoord.z = in_v.texcoord.z;
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float4 u_xlat0_d;
      
      float4 u_xlat16_0;
      
      uint u_xlatu0_d;
      
      float4 u_xlat16_1;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlatu0_d = uint(in_f.texcoord.z);
          
          switch(int(u_xlatu0_d))
              {
              
              case 0:
              u_xlat16_1 = texture(_MainTex0, in_f.texcoord.xy);
              
              u_xlat16_0 = u_xlat16_1;
              
              break;
              
              case 1:
              u_xlat16_1 = texture(_MainTex1, in_f.texcoord.xy);
              
              u_xlat16_0 = u_xlat16_1;
              
              break;
              
              case 2:
              u_xlat16_1 = texture(_MainTex2, in_f.texcoord.xy);
              
              u_xlat16_0 = u_xlat16_1;
              
              break;
              
              case 3:
              u_xlat16_1 = texture(_MainTex3, in_f.texcoord.xy);
              
              u_xlat16_0 = u_xlat16_1;
              
              break;
              
              case 4:
              u_xlat16_0 = texture(_MainTex4, in_f.texcoord.xy);
              
              u_xlat16_0 = u_xlat16_0;
              
              break;
              
              case 5:
              u_xlat16_0 = texture(_MainTex5, in_f.texcoord.xy);
              
              u_xlat16_0 = u_xlat16_0;
              
              break;
              
              case 6:
              u_xlat16_0 = texture(_MainTex6, in_f.texcoord.xy);
              
              u_xlat16_0 = u_xlat16_0;
              
              break;
              
              case 7:
              u_xlat16_0 = texture(_MainTex7, in_f.texcoord.xy);
              
              u_xlat16_0 = u_xlat16_0;
              
              break;
              
              default:
              u_xlat16_0.x = float(1.0);
              
              u_xlat16_0.y = float(1.0);
              
              u_xlat16_0.z = float(1.0);
              
              u_xlat16_0.w = float(1.0);
              
              break;
      
      }
          
          u_xlat0_d = u_xlat16_0 * in_f.color;
          
          out_f.color = u_xlat0_d;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
