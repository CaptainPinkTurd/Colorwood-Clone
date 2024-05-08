Shader "UI/BlurBack"
{
  Properties
  {
    _Color ("Main Color", Color) = (1,1,1,1)
    _MainTex ("Tint Color (RGB)", 2D) = "white" {}
    _Size ("Size", Range(0, 20)) = 1
  }
  SubShader
  {
    Tags
    { 
      "IGNOREPROJECTOR" = "true"
      "QUEUE" = "Transparent"
      "RenderType" = "Opaque"
    }
    Pass // ind: 1, name: 
    {
      Tags
      { 
      }
      ZClip Off
      ZWrite Off
      Cull Off
      Stencil
      { 
        Ref 0
        ReadMask 0
        WriteMask 0
        Pass Keep
        Fail Keep
        ZFail Keep
        PassFront Keep
        FailFront Keep
        ZFailFront Keep
        PassBack Keep
        FailBack Keep
        ZFailBack Keep
      } 
      // m_ProgramMask = 0
      Program "vp"
      {
      }
      Program "fp"
      {
      }
      Program "gp"
      {
      }
      Program "hp"
      {
      }
      Program "dp"
      {
      }
      Program "surface"
      {
      }
      Program "rtp"
      {
      }
      
    } // end phase
    Pass // ind: 2, name: 
    {
      Tags
      { 
        "IGNOREPROJECTOR" = "true"
        "LIGHTMODE" = "ALWAYS"
        "QUEUE" = "Transparent"
        "RenderType" = "Opaque"
      }
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      
      
      uniform float4 unity_ObjectToWorld[4];
      
      uniform float4 unity_MatrixVP[4];
      
      uniform float4 _GrabTexture_TexelSize;
      
      uniform float _Size;
      
      uniform sampler2D _GrabTexture;
      
      
      
      struct appdata_t
      {
          
          float4 vertex : POSITION0;
      
      };
      
      
      struct OUT_Data_Vert
      {
          
          float4 texcoord : TEXCOORD0;
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float4 texcoord : TEXCOORD0;
      
      };
      
      
      struct OUT_Data_Frag
      {
          
          float4 color : SV_Target0;
      
      };
      
      
      float4 u_xlat0;
      
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
          
          u_xlat0 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
          
          out_v.vertex = u_xlat0;
          
          u_xlat0.xy = u_xlat0.ww + u_xlat0.xy;
          
          out_v.texcoord.zw = u_xlat0.zw;
          
          out_v.texcoord.xy = u_xlat0.xy * float2(0.5, 0.5);
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float4 u_xlat0_d;
      
      float4 u_xlat16_0;
      
      float4 u_xlat1_d;
      
      float4 u_xlat16_1;
      
      float4 u_xlat2;
      
      float4 u_xlat16_2;
      
      float4 u_xlat3;
      
      float4 u_xlat16_3;
      
      float4 u_xlat16_4;
      
      float2 u_xlat6;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat0_d.yw = in_f.texcoord.yy;
          
          u_xlat1_d.x = _GrabTexture_TexelSize.x * _Size;
          
          u_xlat2 = u_xlat1_d.xxxx * float4(3.0, -4.0, -3.0, -2.0) + in_f.texcoord.xxxx;
          
          u_xlat0_d.xz = u_xlat2.yz;
          
          u_xlat0_d = u_xlat0_d / in_f.texcoord.wwww;
          
          u_xlat16_3 = texture(_GrabTexture, u_xlat0_d.zw);
          
          u_xlat16_0 = texture(_GrabTexture, u_xlat0_d.xy);
          
          u_xlat3 = u_xlat16_3 * float4(0.0900000036, 0.0900000036, 0.0900000036, 0.0900000036);
          
          u_xlat0_d = u_xlat16_0 * float4(0.0500000007, 0.0500000007, 0.0500000007, 0.0500000007) + u_xlat3;
          
          u_xlat3.x = u_xlat2.w;
          
          u_xlat3.yw = in_f.texcoord.yy;
          
          u_xlat6.xy = u_xlat3.xy / in_f.texcoord.ww;
          
          u_xlat16_4 = texture(_GrabTexture, u_xlat6.xy);
          
          u_xlat0_d = u_xlat16_4 * float4(0.119999997, 0.119999997, 0.119999997, 0.119999997) + u_xlat0_d;
          
          u_xlat3.z = (-_GrabTexture_TexelSize.x) * _Size + in_f.texcoord.x;
          
          u_xlat6.xy = u_xlat3.zw / in_f.texcoord.ww;
          
          u_xlat16_3 = texture(_GrabTexture, u_xlat6.xy);
          
          u_xlat0_d = u_xlat16_3 * float4(0.150000006, 0.150000006, 0.150000006, 0.150000006) + u_xlat0_d;
          
          u_xlat6.xy = in_f.texcoord.xy / in_f.texcoord.ww;
          
          u_xlat16_3 = texture(_GrabTexture, u_xlat6.xy);
          
          u_xlat0_d = u_xlat16_3 * float4(0.180000007, 0.180000007, 0.180000007, 0.180000007) + u_xlat0_d;
          
          u_xlat3.x = _GrabTexture_TexelSize.x * _Size + in_f.texcoord.x;
          
          u_xlat3.yw = in_f.texcoord.yy;
          
          u_xlat6.xy = u_xlat3.xy / in_f.texcoord.ww;
          
          u_xlat16_4 = texture(_GrabTexture, u_xlat6.xy);
          
          u_xlat0_d = u_xlat16_4 * float4(0.150000006, 0.150000006, 0.150000006, 0.150000006) + u_xlat0_d;
          
          u_xlat3.z = u_xlat1_d.x * 2.0 + in_f.texcoord.x;
          
          u_xlat2.z = u_xlat1_d.x * 4.0 + in_f.texcoord.x;
          
          u_xlat1_d.xy = u_xlat3.zw / in_f.texcoord.ww;
          
          u_xlat16_1 = texture(_GrabTexture, u_xlat1_d.xy);
          
          u_xlat0_d = u_xlat16_1 * float4(0.119999997, 0.119999997, 0.119999997, 0.119999997) + u_xlat0_d;
          
          u_xlat2.yw = in_f.texcoord.yy;
          
          u_xlat1_d = u_xlat2 / in_f.texcoord.wwww;
          
          u_xlat16_2 = texture(_GrabTexture, u_xlat1_d.zw);
          
          u_xlat16_1 = texture(_GrabTexture, u_xlat1_d.xy);
          
          u_xlat0_d = u_xlat16_1 * float4(0.0900000036, 0.0900000036, 0.0900000036, 0.0900000036) + u_xlat0_d;
          
          u_xlat0_d = u_xlat16_2 * float4(0.0500000007, 0.0500000007, 0.0500000007, 0.0500000007) + u_xlat0_d;
          
          out_f.color = u_xlat0_d;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 3, name: 
    {
      Tags
      { 
      }
      ZClip Off
      ZWrite Off
      Cull Off
      Stencil
      { 
        Ref 0
        ReadMask 0
        WriteMask 0
        Pass Keep
        Fail Keep
        ZFail Keep
        PassFront Keep
        FailFront Keep
        ZFailFront Keep
        PassBack Keep
        FailBack Keep
        ZFailBack Keep
      } 
      // m_ProgramMask = 0
      Program "vp"
      {
      }
      Program "fp"
      {
      }
      Program "gp"
      {
      }
      Program "hp"
      {
      }
      Program "dp"
      {
      }
      Program "surface"
      {
      }
      Program "rtp"
      {
      }
      
    } // end phase
    Pass // ind: 4, name: 
    {
      Tags
      { 
        "IGNOREPROJECTOR" = "true"
        "LIGHTMODE" = "ALWAYS"
        "QUEUE" = "Transparent"
        "RenderType" = "Opaque"
      }
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      
      
      uniform float4 unity_ObjectToWorld[4];
      
      uniform float4 unity_MatrixVP[4];
      
      uniform float4 _GrabTexture_TexelSize;
      
      uniform float _Size;
      
      uniform sampler2D _GrabTexture;
      
      
      
      struct appdata_t
      {
          
          float4 vertex : POSITION0;
      
      };
      
      
      struct OUT_Data_Vert
      {
          
          float4 texcoord : TEXCOORD0;
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float4 texcoord : TEXCOORD0;
      
      };
      
      
      struct OUT_Data_Frag
      {
          
          float4 color : SV_Target0;
      
      };
      
      
      float4 u_xlat0;
      
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
          
          u_xlat0 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
          
          out_v.vertex = u_xlat0;
          
          u_xlat0.xy = u_xlat0.ww + u_xlat0.xy;
          
          out_v.texcoord.zw = u_xlat0.zw;
          
          out_v.texcoord.xy = u_xlat0.xy * float2(0.5, 0.5);
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float4 u_xlat0_d;
      
      float4 u_xlat16_0;
      
      float4 u_xlat1_d;
      
      float4 u_xlat16_1;
      
      float4 u_xlat2;
      
      float4 u_xlat16_2;
      
      float4 u_xlat3;
      
      float4 u_xlat16_3;
      
      float4 u_xlat16_4;
      
      float2 u_xlat6;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat0_d.xz = in_f.texcoord.xx;
          
          u_xlat1_d.x = _GrabTexture_TexelSize.y * _Size;
          
          u_xlat2 = u_xlat1_d.xxxx * float4(-4.0, 3.0, -3.0, -2.0) + in_f.texcoord.yyyy;
          
          u_xlat0_d.yw = u_xlat2.xz;
          
          u_xlat0_d = u_xlat0_d / in_f.texcoord.wwww;
          
          u_xlat16_3 = texture(_GrabTexture, u_xlat0_d.zw);
          
          u_xlat16_0 = texture(_GrabTexture, u_xlat0_d.xy);
          
          u_xlat3 = u_xlat16_3 * float4(0.0900000036, 0.0900000036, 0.0900000036, 0.0900000036);
          
          u_xlat0_d = u_xlat16_0 * float4(0.0500000007, 0.0500000007, 0.0500000007, 0.0500000007) + u_xlat3;
          
          u_xlat3.y = u_xlat2.w;
          
          u_xlat3.xz = in_f.texcoord.xx;
          
          u_xlat6.xy = u_xlat3.xy / in_f.texcoord.ww;
          
          u_xlat16_4 = texture(_GrabTexture, u_xlat6.xy);
          
          u_xlat0_d = u_xlat16_4 * float4(0.119999997, 0.119999997, 0.119999997, 0.119999997) + u_xlat0_d;
          
          u_xlat3.w = (-_GrabTexture_TexelSize.y) * _Size + in_f.texcoord.y;
          
          u_xlat6.xy = u_xlat3.zw / in_f.texcoord.ww;
          
          u_xlat16_3 = texture(_GrabTexture, u_xlat6.xy);
          
          u_xlat0_d = u_xlat16_3 * float4(0.150000006, 0.150000006, 0.150000006, 0.150000006) + u_xlat0_d;
          
          u_xlat6.xy = in_f.texcoord.xy / in_f.texcoord.ww;
          
          u_xlat16_3 = texture(_GrabTexture, u_xlat6.xy);
          
          u_xlat0_d = u_xlat16_3 * float4(0.180000007, 0.180000007, 0.180000007, 0.180000007) + u_xlat0_d;
          
          u_xlat3.y = _GrabTexture_TexelSize.y * _Size + in_f.texcoord.y;
          
          u_xlat3.xz = in_f.texcoord.xx;
          
          u_xlat6.xy = u_xlat3.xy / in_f.texcoord.ww;
          
          u_xlat16_4 = texture(_GrabTexture, u_xlat6.xy);
          
          u_xlat0_d = u_xlat16_4 * float4(0.150000006, 0.150000006, 0.150000006, 0.150000006) + u_xlat0_d;
          
          u_xlat3.w = u_xlat1_d.x * 2.0 + in_f.texcoord.y;
          
          u_xlat2.w = u_xlat1_d.x * 4.0 + in_f.texcoord.y;
          
          u_xlat1_d.xy = u_xlat3.zw / in_f.texcoord.ww;
          
          u_xlat16_1 = texture(_GrabTexture, u_xlat1_d.xy);
          
          u_xlat0_d = u_xlat16_1 * float4(0.119999997, 0.119999997, 0.119999997, 0.119999997) + u_xlat0_d;
          
          u_xlat2.xz = in_f.texcoord.xx;
          
          u_xlat1_d = u_xlat2 / in_f.texcoord.wwww;
          
          u_xlat16_2 = texture(_GrabTexture, u_xlat1_d.zw);
          
          u_xlat16_1 = texture(_GrabTexture, u_xlat1_d.xy);
          
          u_xlat0_d = u_xlat16_1 * float4(0.0900000036, 0.0900000036, 0.0900000036, 0.0900000036) + u_xlat0_d;
          
          u_xlat0_d = u_xlat16_2 * float4(0.0500000007, 0.0500000007, 0.0500000007, 0.0500000007) + u_xlat0_d;
          
          out_f.color = u_xlat0_d;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 5, name: 
    {
      Tags
      { 
      }
      ZClip Off
      ZWrite Off
      Cull Off
      Stencil
      { 
        Ref 0
        ReadMask 0
        WriteMask 0
        Pass Keep
        Fail Keep
        ZFail Keep
        PassFront Keep
        FailFront Keep
        ZFailFront Keep
        PassBack Keep
        FailBack Keep
        ZFailBack Keep
      } 
      // m_ProgramMask = 0
      Program "vp"
      {
      }
      Program "fp"
      {
      }
      Program "gp"
      {
      }
      Program "hp"
      {
      }
      Program "dp"
      {
      }
      Program "surface"
      {
      }
      Program "rtp"
      {
      }
      
    } // end phase
    Pass // ind: 6, name: 
    {
      Tags
      { 
        "IGNOREPROJECTOR" = "true"
        "LIGHTMODE" = "ALWAYS"
        "QUEUE" = "Transparent"
        "RenderType" = "Opaque"
      }
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      
      
      uniform float4 unity_ObjectToWorld[4];
      
      uniform float4 unity_MatrixVP[4];
      
      uniform float4 _Color;
      
      uniform sampler2D _GrabTexture;
      
      
      
      struct appdata_t
      {
          
          float4 vertex : POSITION0;
      
      };
      
      
      struct OUT_Data_Vert
      {
          
          float4 texcoord : TEXCOORD0;
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float4 texcoord : TEXCOORD0;
      
      };
      
      
      struct OUT_Data_Frag
      {
          
          float4 color : SV_Target0;
      
      };
      
      
      float4 u_xlat0;
      
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
          
          u_xlat0 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
          
          out_v.vertex = u_xlat0;
          
          u_xlat0.xy = u_xlat0.ww + u_xlat0.xy;
          
          out_v.texcoord.zw = u_xlat0.zw;
          
          out_v.texcoord.xy = u_xlat0.xy * float2(0.5, 0.5);
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float2 u_xlat0_d;
      
      float4 u_xlat16_0;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat0_d.xy = in_f.texcoord.xy / in_f.texcoord.ww;
          
          u_xlat16_0 = texture(_GrabTexture, u_xlat0_d.xy);
          
          out_f.color = u_xlat16_0 * _Color;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
