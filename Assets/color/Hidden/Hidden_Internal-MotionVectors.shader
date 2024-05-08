Shader "Hidden/Internal-MotionVectors"
{
  Properties
  {
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
        "LIGHTMODE" = "MOTIONVECTORS"
      }
      ZWrite Off
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      
      
      uniform float4 unity_ObjectToWorld[4];
      
      uniform float4 unity_MatrixVP[4];
      
      uniform float4 _NonJitteredVP[4];
      
      uniform float4 _PreviousVP[4];
      
      uniform float4 _PreviousM[4];
      
      uniform int _HasLastPositionData;
      
      uniform float _MotionVectorDepthBias;
      
      uniform int _ForceNoMotion;
      
      
      
      struct appdata_t
      {
          
          float4 vertex : POSITION0;
          
          float3 texcoord4 : TEXCOORD4;
      
      };
      
      
      struct OUT_Data_Vert
      {
          
          float4 texcoord : TEXCOORD0;
          
          float4 texcoord1 : TEXCOORD1;
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float4 texcoord : TEXCOORD0;
          
          float4 texcoord1 : TEXCOORD1;
      
      };
      
      
      struct OUT_Data_Frag
      {
          
          float4 color : SV_Target0;
      
      };
      
      
      float4 u_xlat0;
      
      float4 u_xlat1;
      
      float4 u_xlat2;
      
      OUT_Data_Vert vert(appdata_t in_v)
      {
          
          u_xlat0 = in_v.vertex.yyyy * unity_ObjectToWorld[1];
          
          u_xlat0 = unity_ObjectToWorld[0] * in_v.vertex.xxxx + u_xlat0;
          
          u_xlat0 = unity_ObjectToWorld[2] * in_v.vertex.zzzz + u_xlat0;
          
          u_xlat1 = unity_ObjectToWorld[3] * in_v.vertex.wwww + u_xlat0;
          
          u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
          
          u_xlat2 = u_xlat1.yyyy * _NonJitteredVP[1];
          
          u_xlat2 = _NonJitteredVP[0] * u_xlat1.xxxx + u_xlat2;
          
          u_xlat2 = _NonJitteredVP[2] * u_xlat1.zzzz + u_xlat2;
          
          out_v.texcoord = _NonJitteredVP[3] * u_xlat1.wwww + u_xlat2;
          
          u_xlat1.xyz = in_v.texcoord4.xyz;
          
          u_xlat1.w = 1.0;
          
          u_xlat1 = (_HasLastPositionData != 0) ? u_xlat1 : in_v.vertex;
          
          u_xlat2 = u_xlat1.yyyy * _PreviousM[1];
          
          u_xlat2 = _PreviousM[0] * u_xlat1.xxxx + u_xlat2;
          
          u_xlat2 = _PreviousM[2] * u_xlat1.zzzz + u_xlat2;
          
          u_xlat1 = _PreviousM[3] * u_xlat1.wwww + u_xlat2;
          
          u_xlat2 = u_xlat1.yyyy * _PreviousVP[1];
          
          u_xlat2 = _PreviousVP[0] * u_xlat1.xxxx + u_xlat2;
          
          u_xlat2 = _PreviousVP[2] * u_xlat1.zzzz + u_xlat2;
          
          out_v.texcoord1 = _PreviousVP[3] * u_xlat1.wwww + u_xlat2;
          
          u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
          
          u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
          
          u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
          
          u_xlat0 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
          
          out_v.vertex.z = _MotionVectorDepthBias * u_xlat0.w + u_xlat0.z;
          
          out_v.vertex.xyw = u_xlat0.xyw;
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float2 u_xlat0_d;
      
      float u_xlat16_1;
      
      float2 u_xlat16_3;
      
      float2 u_xlat4;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat0_d.xy = in_f.texcoord1.xy / in_f.texcoord1.ww;
          
          u_xlat0_d.xy = u_xlat0_d.xy + float2(1.0, 1.0);
          
          u_xlat0_d.xy = u_xlat0_d.xy * float2(0.5, 0.5);
          
          u_xlat4.xy = in_f.texcoord.xy / in_f.texcoord.ww;
          
          u_xlat4.xy = u_xlat4.xy + float2(1.0, 1.0);
          
          u_xlat0_d.xy = u_xlat4.xy * float2(0.5, 0.5) + (-u_xlat0_d.xy);
          
          u_xlat16_1 = (_ForceNoMotion != 0) ? 1.0 : 0.0;
          
          out_f.color.xy = float2(u_xlat16_1) * (-u_xlat0_d.xy) + u_xlat0_d.xy;
          
          u_xlat16_3.x = float(-0.0);
          
          u_xlat16_3.y = float(-1.0);
          
          out_f.color.zw = float2(u_xlat16_1) * u_xlat16_3.xy + float2(0.0, 1.0);
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 2, name: 
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
      
      
      uniform float4 _ProjectionParams;
      
      uniform float4 unity_ObjectToWorld[4];
      
      uniform float4 unity_MatrixVP[4];
      
      uniform float4 _ZBufferParams;
      
      uniform float4 unity_CameraToWorld[4];
      
      uniform float4 _NonJitteredVP[4];
      
      uniform float4 _PreviousVP[4];
      
      uniform sampler2D _CameraDepthTexture;
      
      
      
      struct appdata_t
      {
          
          float4 vertex : POSITION0;
          
          float3 normal : NORMAL0;
      
      };
      
      
      struct OUT_Data_Vert
      {
          
          float2 texcoord : TEXCOORD0;
          
          float3 texcoord1 : TEXCOORD1;
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float2 texcoord : TEXCOORD0;
          
          float3 texcoord1 : TEXCOORD1;
      
      };
      
      
      struct OUT_Data_Frag
      {
          
          float4 color : SV_Target0;
      
      };
      
      
      float4 u_xlat0;
      
      float4 u_xlat1;
      
      float u_xlat2;
      
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
          
          u_xlat2 = u_xlat0.y * _ProjectionParams.x;
          
          u_xlat0.xz = u_xlat0.xw * float2(0.5, 0.5);
          
          u_xlat0.w = u_xlat2 * 0.5;
          
          out_v.texcoord.xy = u_xlat0.zz + u_xlat0.xw;
          
          out_v.texcoord1.xyz = in_v.normal.xyz;
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float4 u_xlat0_d;
      
      float4 u_xlat1_d;
      
      float3 u_xlat2_d;
      
      float3 u_xlat3;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat0_d.x = texture(_CameraDepthTexture, in_f.texcoord.xy).x;
          
          u_xlat0_d.x = _ZBufferParams.x * u_xlat0_d.x + _ZBufferParams.y;
          
          u_xlat0_d.x = float(1.0) / u_xlat0_d.x;
          
          u_xlat3.x = _ProjectionParams.z / in_f.texcoord1.z;
          
          u_xlat3.xyz = u_xlat3.xxx * in_f.texcoord1.xyz;
          
          u_xlat0_d.xyz = u_xlat0_d.xxx * u_xlat3.xyz;
          
          u_xlat1_d = u_xlat0_d.yyyy * unity_CameraToWorld[1];
          
          u_xlat1_d = unity_CameraToWorld[0] * u_xlat0_d.xxxx + u_xlat1_d;
          
          u_xlat0_d = unity_CameraToWorld[2] * u_xlat0_d.zzzz + u_xlat1_d;
          
          u_xlat0_d = u_xlat0_d + unity_CameraToWorld[3];
          
          u_xlat1_d.xyz = u_xlat0_d.yyy * _PreviousVP[1].xyw;
          
          u_xlat1_d.xyz = _PreviousVP[0].xyw * u_xlat0_d.xxx + u_xlat1_d.xyz;
          
          u_xlat1_d.xyz = _PreviousVP[2].xyw * u_xlat0_d.zzz + u_xlat1_d.xyz;
          
          u_xlat1_d.xyz = _PreviousVP[3].xyw * u_xlat0_d.www + u_xlat1_d.xyz;
          
          u_xlat1_d.xy = u_xlat1_d.xy / u_xlat1_d.zz;
          
          u_xlat1_d.xy = u_xlat1_d.xy + float2(1.0, 1.0);
          
          u_xlat1_d.xy = u_xlat1_d.xy * float2(0.5, 0.5);
          
          u_xlat2_d.xyz = u_xlat0_d.yyy * _NonJitteredVP[1].xyw;
          
          u_xlat2_d.xyz = _NonJitteredVP[0].xyw * u_xlat0_d.xxx + u_xlat2_d.xyz;
          
          u_xlat0_d.xyz = _NonJitteredVP[2].xyw * u_xlat0_d.zzz + u_xlat2_d.xyz;
          
          u_xlat0_d.xyz = _NonJitteredVP[3].xyw * u_xlat0_d.www + u_xlat0_d.xyz;
          
          u_xlat0_d.xy = u_xlat0_d.xy / u_xlat0_d.zz;
          
          u_xlat0_d.xy = u_xlat0_d.xy + float2(1.0, 1.0);
          
          u_xlat0_d.xy = u_xlat0_d.xy * float2(0.5, 0.5) + (-u_xlat1_d.xy);
          
          out_f.color.xy = u_xlat0_d.xy;
          
          out_f.color.zw = float2(0.0, 1.0);
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 3, name: 
    {
      Tags
      { 
      }
      ZTest Always
      Cull Off
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      
      
      uniform float4 _ProjectionParams;
      
      uniform float4 unity_ObjectToWorld[4];
      
      uniform float4 unity_MatrixVP[4];
      
      uniform float4 _ZBufferParams;
      
      uniform float4 unity_CameraToWorld[4];
      
      uniform float4 _NonJitteredVP[4];
      
      uniform float4 _PreviousVP[4];
      
      uniform sampler2D _CameraDepthTexture;
      
      
      
      struct appdata_t
      {
          
          float4 vertex : POSITION0;
          
          float3 normal : NORMAL0;
      
      };
      
      
      struct OUT_Data_Vert
      {
          
          float2 texcoord : TEXCOORD0;
          
          float3 texcoord1 : TEXCOORD1;
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float2 texcoord : TEXCOORD0;
          
          float3 texcoord1 : TEXCOORD1;
      
      };
      
      
      struct OUT_Data_Frag
      {
          
          float SV_Depth : SV_Depth;
          
          float4 color : SV_Target0;
      
      };
      
      
      float4 u_xlat0;
      
      float4 u_xlat1;
      
      float u_xlat2;
      
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
          
          u_xlat2 = u_xlat0.y * _ProjectionParams.x;
          
          u_xlat0.xz = u_xlat0.xw * float2(0.5, 0.5);
          
          u_xlat0.w = u_xlat2 * 0.5;
          
          out_v.texcoord.xy = u_xlat0.zz + u_xlat0.xw;
          
          out_v.texcoord1.xyz = in_v.normal.xyz;
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float4 u_xlat0_d;
      
      float4 u_xlat1_d;
      
      float3 u_xlat2_d;
      
      float u_xlat9;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat0_d.x = _ProjectionParams.z / in_f.texcoord1.z;
          
          u_xlat0_d.xyz = u_xlat0_d.xxx * in_f.texcoord1.xyz;
          
          u_xlat9 = texture(_CameraDepthTexture, in_f.texcoord.xy).x;
          
          u_xlat1_d.x = _ZBufferParams.x * u_xlat9 + _ZBufferParams.y;
          
          out_f.SV_Depth = u_xlat9;
          
          u_xlat9 = float(1.0) / u_xlat1_d.x;
          
          u_xlat0_d.xyz = float3(u_xlat9) * u_xlat0_d.xyz;
          
          u_xlat1_d = u_xlat0_d.yyyy * unity_CameraToWorld[1];
          
          u_xlat1_d = unity_CameraToWorld[0] * u_xlat0_d.xxxx + u_xlat1_d;
          
          u_xlat0_d = unity_CameraToWorld[2] * u_xlat0_d.zzzz + u_xlat1_d;
          
          u_xlat0_d = u_xlat0_d + unity_CameraToWorld[3];
          
          u_xlat1_d.xyz = u_xlat0_d.yyy * _PreviousVP[1].xyw;
          
          u_xlat1_d.xyz = _PreviousVP[0].xyw * u_xlat0_d.xxx + u_xlat1_d.xyz;
          
          u_xlat1_d.xyz = _PreviousVP[2].xyw * u_xlat0_d.zzz + u_xlat1_d.xyz;
          
          u_xlat1_d.xyz = _PreviousVP[3].xyw * u_xlat0_d.www + u_xlat1_d.xyz;
          
          u_xlat1_d.xy = u_xlat1_d.xy / u_xlat1_d.zz;
          
          u_xlat1_d.xy = u_xlat1_d.xy + float2(1.0, 1.0);
          
          u_xlat1_d.xy = u_xlat1_d.xy * float2(0.5, 0.5);
          
          u_xlat2_d.xyz = u_xlat0_d.yyy * _NonJitteredVP[1].xyw;
          
          u_xlat2_d.xyz = _NonJitteredVP[0].xyw * u_xlat0_d.xxx + u_xlat2_d.xyz;
          
          u_xlat0_d.xyz = _NonJitteredVP[2].xyw * u_xlat0_d.zzz + u_xlat2_d.xyz;
          
          u_xlat0_d.xyz = _NonJitteredVP[3].xyw * u_xlat0_d.www + u_xlat0_d.xyz;
          
          u_xlat0_d.xy = u_xlat0_d.xy / u_xlat0_d.zz;
          
          u_xlat0_d.xy = u_xlat0_d.xy + float2(1.0, 1.0);
          
          u_xlat0_d.xy = u_xlat0_d.xy * float2(0.5, 0.5) + (-u_xlat1_d.xy);
          
          out_f.color.xy = u_xlat0_d.xy;
          
          out_f.color.zw = float2(0.0, 1.0);
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
