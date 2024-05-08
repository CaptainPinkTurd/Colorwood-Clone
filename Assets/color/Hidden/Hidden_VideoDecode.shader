Shader "Hidden/VideoDecode"
{
  Properties
  {
    _MainTex ("_MainTex (A)", 2D) = "black" {}
    _SecondTex ("_SecondTex (A)", 2D) = "black" {}
    _ThirdTex ("_ThirdTex (A)", 2D) = "black" {}
  }
  SubShader
  {
    Tags
    { 
    }
    Pass // ind: 1, name: YCbCr_To_RGB1
    {
      Name "YCbCr_To_RGB1"
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
      
      uniform float4 _MainTex_ST;
      
      uniform sampler2D _MainTex;
      
      uniform sampler2D _SecondTex;
      
      uniform sampler2D _ThirdTex;
      
      
      
      struct appdata_t
      {
          
          float4 vertex : POSITION0;
          
          float2 texcoord : TEXCOORD0;
      
      };
      
      
      struct OUT_Data_Vert
      {
          
          float2 texcoord : TEXCOORD0;
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float2 texcoord : TEXCOORD0;
      
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
          
          out_v.vertex = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
          
          out_v.texcoord.xy = in_v.texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float u_xlat16_0;
      
      float2 u_xlat16_1;
      
      float u_xlat16_2;
      
      float u_xlat16_3;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          out_f.color.w = 1.0;
          
          u_xlat16_0 = texture(_SecondTex, in_f.texcoord.xy).w;
          
          u_xlat16_1.xy = float2(u_xlat16_0) * float2(0.390625, 1.984375);
          
          u_xlat16_0 = texture(_MainTex, in_f.texcoord.xy).w;
          
          u_xlat16_1.x = u_xlat16_0 * 1.15625 + (-u_xlat16_1.x);
          
          u_xlat16_3 = u_xlat16_0 * 1.15625 + u_xlat16_1.y;
          
          out_f.color.z = u_xlat16_3 + -1.06861997;
          
          u_xlat16_2 = texture(_ThirdTex, in_f.texcoord.xy).w;
          
          u_xlat16_1.x = (-u_xlat16_2) * 0.8125 + u_xlat16_1.x;
          
          u_xlat16_3 = u_xlat16_2 * 1.59375;
          
          u_xlat16_1.y = u_xlat16_0 * 1.15625 + u_xlat16_3;
          
          out_f.color.xy = u_xlat16_1.yx + float2(-0.872539997, 0.531369984);
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 2, name: YCbCrA_To_RGBAFull
    {
      Name "YCbCrA_To_RGBAFull"
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
      
      uniform float4 _MainTex_ST;
      
      uniform sampler2D _MainTex;
      
      uniform sampler2D _SecondTex;
      
      uniform sampler2D _ThirdTex;
      
      
      
      struct appdata_t
      {
          
          float4 vertex : POSITION0;
          
          float2 texcoord : TEXCOORD0;
      
      };
      
      
      struct OUT_Data_Vert
      {
          
          float2 texcoord : TEXCOORD0;
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float2 texcoord : TEXCOORD0;
      
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
          
          out_v.vertex = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
          
          out_v.texcoord.xy = in_v.texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float2 u_xlat0_d;
      
      float u_xlat16_0;
      
      float2 u_xlat16_1;
      
      float u_xlat16_3;
      
      float u_xlat16_4;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat0_d.xy = in_f.texcoord.xy * float2(0.5, 1.0) + float2(0.5, 0.0);
          
          u_xlat16_0 = texture(_MainTex, u_xlat0_d.xy).w;
          
          out_f.color.w = u_xlat16_0;
          
          u_xlat0_d.xy = in_f.texcoord.xy * float2(0.5, 1.0);
          
          u_xlat16_4 = texture(_SecondTex, u_xlat0_d.xy).w;
          
          u_xlat16_1.xy = float2(u_xlat16_4) * float2(0.390625, 1.984375);
          
          u_xlat16_4 = texture(_MainTex, u_xlat0_d.xy).w;
          
          u_xlat16_0 = texture(_ThirdTex, u_xlat0_d.xy).w;
          
          u_xlat16_1.x = u_xlat16_4 * 1.15625 + (-u_xlat16_1.x);
          
          u_xlat16_3 = u_xlat16_4 * 1.15625 + u_xlat16_1.y;
          
          out_f.color.z = u_xlat16_3 + -1.06861997;
          
          u_xlat16_1.x = (-u_xlat16_0) * 0.8125 + u_xlat16_1.x;
          
          u_xlat16_3 = u_xlat16_0 * 1.59375;
          
          u_xlat16_1.y = u_xlat16_4 * 1.15625 + u_xlat16_3;
          
          out_f.color.xy = u_xlat16_1.yx + float2(-0.872539997, 0.531369984);
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 3, name: YCbCrA_To_RGBA
    {
      Name "YCbCrA_To_RGBA"
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
      
      uniform float4 _MainTex_ST;
      
      uniform sampler2D _MainTex;
      
      uniform sampler2D _SecondTex;
      
      uniform sampler2D _ThirdTex;
      
      
      
      struct appdata_t
      {
          
          float4 vertex : POSITION0;
          
          float2 texcoord : TEXCOORD0;
      
      };
      
      
      struct OUT_Data_Vert
      {
          
          float2 texcoord : TEXCOORD0;
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float2 texcoord : TEXCOORD0;
      
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
          
          out_v.vertex = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
          
          out_v.texcoord.xy = in_v.texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float2 u_xlat0_d;
      
      float u_xlat16_0;
      
      float2 u_xlat16_1;
      
      float u_xlat16_3;
      
      float u_xlat16_4;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat0_d.xy = in_f.texcoord.xy * float2(0.5, 1.0) + float2(0.5, 0.0);
          
          u_xlat16_0 = texture(_MainTex, u_xlat0_d.xy).w;
          
          u_xlat16_1.x = u_xlat16_0 + -0.0627449974;
          
          out_f.color.w = u_xlat16_1.x * 1.15625;
          
          u_xlat0_d.xy = in_f.texcoord.xy * float2(0.5, 1.0);
          
          u_xlat16_4 = texture(_SecondTex, u_xlat0_d.xy).w;
          
          u_xlat16_1.xy = float2(u_xlat16_4) * float2(0.390625, 1.984375);
          
          u_xlat16_4 = texture(_MainTex, u_xlat0_d.xy).w;
          
          u_xlat16_0 = texture(_ThirdTex, u_xlat0_d.xy).w;
          
          u_xlat16_1.x = u_xlat16_4 * 1.15625 + (-u_xlat16_1.x);
          
          u_xlat16_3 = u_xlat16_4 * 1.15625 + u_xlat16_1.y;
          
          out_f.color.z = u_xlat16_3 + -1.06861997;
          
          u_xlat16_1.x = (-u_xlat16_0) * 0.8125 + u_xlat16_1.x;
          
          u_xlat16_3 = u_xlat16_0 * 1.59375;
          
          u_xlat16_1.y = u_xlat16_4 * 1.15625 + u_xlat16_3;
          
          out_f.color.xy = u_xlat16_1.yx + float2(-0.872539997, 0.531369984);
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 4, name: Flip_RGBA_To_RGBA
    {
      Name "Flip_RGBA_To_RGBA"
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
      
      uniform float4 _MainTex_ST;
      
      uniform sampler2D _MainTex;
      
      
      
      struct appdata_t
      {
          
          float4 vertex : POSITION0;
          
          float2 texcoord : TEXCOORD0;
      
      };
      
      
      struct OUT_Data_Vert
      {
          
          float2 texcoord : TEXCOORD0;
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float2 texcoord : TEXCOORD0;
      
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
          
          out_v.vertex = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
          
          u_xlat0.xy = in_v.texcoord.xy * float2(1.0, -1.0) + float2(0.0, 1.0);
          
          out_v.texcoord.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float4 u_xlat16_0;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat16_0 = texture(_MainTex, in_f.texcoord.xy);
          
          out_f.color = u_xlat16_0;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 5, name: Flip_RGBASplit_To_RGBA
    {
      Name "Flip_RGBASplit_To_RGBA"
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
      
      uniform float4 _MainTex_ST;
      
      uniform sampler2D _MainTex;
      
      
      
      struct appdata_t
      {
          
          float4 vertex : POSITION0;
          
          float2 texcoord : TEXCOORD0;
      
      };
      
      
      struct OUT_Data_Vert
      {
          
          float2 texcoord : TEXCOORD0;
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float2 texcoord : TEXCOORD0;
      
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
          
          out_v.vertex = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
          
          u_xlat0.xy = in_v.texcoord.xy * float2(1.0, -1.0) + float2(0.0, 1.0);
          
          out_v.texcoord.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float2 u_xlat0_d;
      
      float4 u_xlat16_0;
      
      float2 u_xlat1_d;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat0_d.xy = in_f.texcoord.xy * float2(0.5, 1.0);
          
          u_xlat16_0.xyz = texture(_MainTex, u_xlat0_d.xy).xyz;
          
          u_xlat1_d.xy = in_f.texcoord.xy * float2(0.5, 1.0) + float2(0.5, 0.0);
          
          u_xlat16_0.w = texture(_MainTex, u_xlat1_d.xy).y;
          
          out_f.color = u_xlat16_0;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 6, name: Flip_NV12_To_RGB1
    {
      Name "Flip_NV12_To_RGB1"
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
      
      uniform float4 _MainTex_ST;
      
      uniform float4 _MatrixColorConversion[4];
      
      uniform sampler2D _MainTex;
      
      uniform sampler2D _SecondTex;
      
      
      
      struct appdata_t
      {
          
          float4 vertex : POSITION0;
          
          float2 texcoord : TEXCOORD0;
      
      };
      
      
      struct OUT_Data_Vert
      {
          
          float2 texcoord : TEXCOORD0;
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float2 texcoord : TEXCOORD0;
      
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
          
          out_v.vertex = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
          
          u_xlat0.xy = in_v.texcoord.xy * float2(1.0, -1.0) + float2(0.0, 1.0);
          
          out_v.texcoord.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float4 u_xlat0_d;
      
      float3 u_xlat1_d;
      
      float3 u_xlat2;
      
      float2 u_xlat16_3;
      
      float u_xlat16_13;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat0_d.w = 1.0;
          
          u_xlat1_d.x = _MatrixColorConversion[0].x;
          
          u_xlat1_d.y = _MatrixColorConversion[1].x;
          
          u_xlat1_d.z = _MatrixColorConversion[2].x;
          
          u_xlat16_13 = texture(_MainTex, in_f.texcoord.xy).w;
          
          u_xlat2.x = u_xlat16_13 + -0.0625;
          
          u_xlat16_3.xy = texture(_SecondTex, in_f.texcoord.xy).xy;
          
          u_xlat2.yz = u_xlat16_3.xy + float2(-0.5, -0.5);
          
          u_xlat0_d.x = dot(u_xlat1_d.xyz, u_xlat2.xyz);
          
          u_xlat1_d.x = _MatrixColorConversion[0].y;
          
          u_xlat1_d.y = _MatrixColorConversion[1].y;
          
          u_xlat1_d.z = _MatrixColorConversion[2].y;
          
          u_xlat0_d.y = dot(u_xlat1_d.xyz, u_xlat2.xyz);
          
          u_xlat1_d.x = _MatrixColorConversion[0].z;
          
          u_xlat1_d.y = _MatrixColorConversion[1].z;
          
          u_xlat1_d.z = _MatrixColorConversion[2].z;
          
          u_xlat0_d.z = dot(u_xlat1_d.xyz, u_xlat2.xyz);
          
          out_f.color = u_xlat0_d;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 7, name: Flip_NV12_To_RGBA
    {
      Name "Flip_NV12_To_RGBA"
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
      
      uniform float4 _MainTex_ST;
      
      uniform sampler2D _MainTex;
      
      uniform sampler2D _SecondTex;
      
      
      
      struct appdata_t
      {
          
          float4 vertex : POSITION0;
          
          float2 texcoord : TEXCOORD0;
      
      };
      
      
      struct OUT_Data_Vert
      {
          
          float2 texcoord : TEXCOORD0;
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float2 texcoord : TEXCOORD0;
      
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
          
          out_v.vertex = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
          
          u_xlat0.xy = in_v.texcoord.xy * float2(1.0, -1.0) + float2(0.0, 1.0);
          
          out_v.texcoord.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float2 u_xlat0_d;
      
      float u_xlat16_0;
      
      float3 u_xlat1_d;
      
      float3 u_xlat16_2;
      
      float2 u_xlat16_3;
      
      float u_xlat16_5;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat0_d.y = in_f.texcoord.y;
          
          u_xlat1_d.xyz = in_f.texcoord.xxy * float3(0.5, 0.5, 1.0);
          
          u_xlat0_d.x = _MainTex_ST.x * 0.5 + u_xlat1_d.x;
          
          u_xlat16_0 = texture(_MainTex, u_xlat0_d.xy).w;
          
          u_xlat16_2.x = u_xlat16_0 + -0.0627449974;
          
          out_f.color.w = u_xlat16_2.x * 1.15625;
          
          u_xlat16_0 = texture(_MainTex, u_xlat1_d.yz).w;
          
          u_xlat16_3.xy = texture(_SecondTex, u_xlat1_d.yz).xy;
          
          u_xlat16_2.xyz = u_xlat16_3.yxx * float3(1.59375, 0.390625, 1.984375);
          
          u_xlat16_5 = u_xlat16_0 * 1.15625 + (-u_xlat16_2.y);
          
          u_xlat16_2.xz = float2(u_xlat16_0) * float2(1.15625, 1.15625) + u_xlat16_2.xz;
          
          out_f.color.xz = u_xlat16_2.xz + float2(-0.872539997, -1.06861997);
          
          u_xlat16_2.x = (-u_xlat16_3.y) * 0.8125 + u_xlat16_5;
          
          out_f.color.y = u_xlat16_2.x + 0.531369984;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 8, name: Flip_P010_To_RGB1
    {
      Name "Flip_P010_To_RGB1"
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
      
      uniform float4 _MainTex_ST;
      
      uniform sampler2D _MainTex;
      
      uniform sampler2D _SecondTex;
      
      
      
      struct appdata_t
      {
          
          float4 vertex : POSITION0;
          
          float2 texcoord : TEXCOORD0;
      
      };
      
      
      struct OUT_Data_Vert
      {
          
          float2 texcoord : TEXCOORD0;
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float2 texcoord : TEXCOORD0;
      
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
          
          out_v.vertex = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
          
          u_xlat0.xy = in_v.texcoord.xy * float2(1.0, -1.0) + float2(0.0, 1.0);
          
          out_v.texcoord.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float3 u_xlat0_d;
      
      float3 u_xlat16_0;
      
      float4 u_xlat1_d;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat16_0.x = texture(_MainTex, in_f.texcoord.xy).x;
          
          u_xlat16_0.yz = texture(_SecondTex, in_f.texcoord.xy).xy;
          
          u_xlat0_d.xyz = u_xlat16_0.xyz * float3(64.0615845, 64.0615845, 64.0615845) + float3(-0.0625, -0.5, -0.5);
          
          u_xlat1_d.x = dot(float2(1.16439998, 1.79270005), u_xlat0_d.xz);
          
          u_xlat1_d.y = dot(float3(1.16439998, -0.213300005, -0.532899976), u_xlat0_d.xyz);
          
          u_xlat1_d.z = dot(float2(1.16439998, 2.11240005), u_xlat0_d.xy);
          
          u_xlat1_d.w = 1.0;
          
          out_f.color = u_xlat1_d;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
