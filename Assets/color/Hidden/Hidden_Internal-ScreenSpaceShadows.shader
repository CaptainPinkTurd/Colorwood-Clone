Shader "Hidden/Internal-ScreenSpaceShadows"
{
  Properties
  {
    _ShadowMapTexture ("", any) = "" {}
    _ODSWorldTexture ("", 2D) = "" {}
  }
  SubShader
  {
    Tags
    { 
      "ShadowmapFilter" = "HardShadow"
    }
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "ShadowmapFilter" = "HardShadow"
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
      
      uniform float4 unity_CameraInvProjection[4];
      
      uniform float4 unity_ObjectToWorld[4];
      
      uniform float4 unity_MatrixVP[4];
      
      uniform float4 _ZBufferParams;
      
      uniform float4 unity_OrthoParams;
      
      uniform float4 unity_CameraToWorld[4];
      
      uniform float4 _LightSplitsNear;
      
      uniform float4 _LightSplitsFar;
      
      uniform float4 unity_WorldToShadow[16];
      
      uniform float4 _LightShadowData;
      
      uniform sampler2D _CameraDepthTexture;
      
      uniform sampler2D _ShadowMapTexture;
      
      uniform sampler2D hlslcc_zcmp_ShadowMapTexture;
      
      
      
      struct appdata_t
      {
          
          float4 vertex : POSITION0;
          
          float2 texcoord : TEXCOORD0;
          
          float3 texcoord1 : TEXCOORD1;
      
      };
      
      
      struct OUT_Data_Vert
      {
          
          float4 texcoord : TEXCOORD0;
          
          float3 texcoord1 : TEXCOORD1;
          
          float3 texcoord2 : TEXCOORD2;
          
          float3 texcoord3 : TEXCOORD3;
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float4 texcoord : TEXCOORD0;
          
          float3 texcoord1 : TEXCOORD1;
          
          float3 texcoord2 : TEXCOORD2;
          
          float3 texcoord3 : TEXCOORD3;
      
      };
      
      
      struct OUT_Data_Frag
      {
          
          float4 color : SV_Target0;
      
      };
      
      
      float4 u_xlat0;
      
      float4 u_xlat1;
      
      float3 u_xlat2;
      
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
          
          u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
          
          u_xlat1.xzw = u_xlat0.xwy * float3(0.5, 0.5, 0.5);
          
          u_xlat2.xyz = u_xlat0.yyy * unity_CameraInvProjection[1].xyz;
          
          u_xlat0.xyz = unity_CameraInvProjection[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
          
          out_v.texcoord.zw = u_xlat1.zz + u_xlat1.xw;
          
          out_v.texcoord.xy = in_v.texcoord.xy;
          
          out_v.texcoord1.xyz = in_v.texcoord1.xyz;
          
          u_xlat1.xyz = u_xlat0.xyz + (-unity_CameraInvProjection[2].xyz);
          
          u_xlat0.xyz = u_xlat0.xyz + unity_CameraInvProjection[2].xyz;
          
          u_xlat0.xyz = u_xlat0.xyz + unity_CameraInvProjection[3].xyz;
          
          u_xlat1.xyz = u_xlat1.xyz + unity_CameraInvProjection[3].xyz;
          
          u_xlat1.w = (-u_xlat1.z);
          
          out_v.texcoord2.xyz = u_xlat1.xyw;
          
          u_xlat0.w = (-u_xlat0.z);
          
          out_v.texcoord3.xyz = u_xlat0.xyw;
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float4 u_xlat0_d;
      
      float4 u_xlat1_d;
      
      float4 u_xlat16_1;
      
      bool4 u_xlatb1;
      
      float4 u_xlat2_d;
      
      bool4 u_xlatb2;
      
      float3 u_xlat3;
      
      float u_xlat4;
      
      float u_xlat8;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat0_d.x = texture(_CameraDepthTexture, in_f.texcoord.xy).x;
          
          u_xlat4 = _ZBufferParams.x * u_xlat0_d.x + _ZBufferParams.y;
          
          u_xlat4 = float(1.0) / u_xlat4;
          
          u_xlat8 = (-u_xlat4) + u_xlat0_d.x;
          
          u_xlat4 = unity_OrthoParams.w * u_xlat8 + u_xlat4;
          
          u_xlat1_d.xyz = (-in_f.texcoord2.xyz) + in_f.texcoord3.xyz;
          
          u_xlat0_d.xzw = u_xlat0_d.xxx * u_xlat1_d.xyz + in_f.texcoord2.xyz;
          
          u_xlat0_d.xzw = (-in_f.texcoord1.xyz) * float3(u_xlat4) + u_xlat0_d.xzw;
          
          u_xlat1_d.xyz = float3(u_xlat4) * in_f.texcoord1.xyz;
          
          u_xlat0_d.xyz = unity_OrthoParams.www * u_xlat0_d.xzw + u_xlat1_d.xyz;
          
          u_xlatb1 = greaterThanEqual(u_xlat0_d.zzzz, _LightSplitsNear);
          
          u_xlat1_d.x = u_xlatb1.x ? float(1.0) : 0.0;
          
          u_xlat1_d.y = u_xlatb1.y ? float(1.0) : 0.0;
          
          u_xlat1_d.z = u_xlatb1.z ? float(1.0) : 0.0;
          
          u_xlat1_d.w = u_xlatb1.w ? float(1.0) : 0.0;
      
      ;
          
          u_xlatb2 = lessThan(u_xlat0_d.zzzz, _LightSplitsFar);
          
          u_xlat2_d.x = u_xlatb2.x ? float(1.0) : 0.0;
          
          u_xlat2_d.y = u_xlatb2.y ? float(1.0) : 0.0;
          
          u_xlat2_d.z = u_xlatb2.z ? float(1.0) : 0.0;
          
          u_xlat2_d.w = u_xlatb2.w ? float(1.0) : 0.0;
      
      ;
          
          u_xlat16_1 = u_xlat1_d * u_xlat2_d;
          
          u_xlat2_d = u_xlat0_d.yyyy * unity_CameraToWorld[1];
          
          u_xlat2_d = unity_CameraToWorld[0] * u_xlat0_d.xxxx + u_xlat2_d;
          
          u_xlat0_d = unity_CameraToWorld[2] * u_xlat0_d.zzzz + u_xlat2_d;
          
          u_xlat0_d = u_xlat0_d + unity_CameraToWorld[3];
          
          u_xlat2_d.xyz = u_xlat0_d.yyy * unity_WorldToShadow[5].xyz;
          
          u_xlat2_d.xyz = unity_WorldToShadow[4].xyz * u_xlat0_d.xxx + u_xlat2_d.xyz;
          
          u_xlat2_d.xyz = unity_WorldToShadow[6].xyz * u_xlat0_d.zzz + u_xlat2_d.xyz;
          
          u_xlat2_d.xyz = unity_WorldToShadow[7].xyz * u_xlat0_d.www + u_xlat2_d.xyz;
          
          u_xlat2_d.xyz = u_xlat16_1.yyy * u_xlat2_d.xyz;
          
          u_xlat3.xyz = u_xlat0_d.yyy * unity_WorldToShadow[1].xyz;
          
          u_xlat3.xyz = unity_WorldToShadow[0].xyz * u_xlat0_d.xxx + u_xlat3.xyz;
          
          u_xlat3.xyz = unity_WorldToShadow[2].xyz * u_xlat0_d.zzz + u_xlat3.xyz;
          
          u_xlat3.xyz = unity_WorldToShadow[3].xyz * u_xlat0_d.www + u_xlat3.xyz;
          
          u_xlat2_d.xyz = u_xlat3.xyz * u_xlat16_1.xxx + u_xlat2_d.xyz;
          
          u_xlat3.xyz = u_xlat0_d.yyy * unity_WorldToShadow[9].xyz;
          
          u_xlat3.xyz = unity_WorldToShadow[8].xyz * u_xlat0_d.xxx + u_xlat3.xyz;
          
          u_xlat3.xyz = unity_WorldToShadow[10].xyz * u_xlat0_d.zzz + u_xlat3.xyz;
          
          u_xlat3.xyz = unity_WorldToShadow[11].xyz * u_xlat0_d.www + u_xlat3.xyz;
          
          u_xlat2_d.xyz = u_xlat3.xyz * u_xlat16_1.zzz + u_xlat2_d.xyz;
          
          u_xlat3.xyz = u_xlat0_d.yyy * unity_WorldToShadow[13].xyz;
          
          u_xlat3.xyz = unity_WorldToShadow[12].xyz * u_xlat0_d.xxx + u_xlat3.xyz;
          
          u_xlat0_d.xyz = unity_WorldToShadow[14].xyz * u_xlat0_d.zzz + u_xlat3.xyz;
          
          u_xlat0_d.xyz = unity_WorldToShadow[15].xyz * u_xlat0_d.www + u_xlat0_d.xyz;
          
          u_xlat0_d.xyz = u_xlat0_d.xyz * u_xlat16_1.www + u_xlat2_d.xyz;
          
          float3 txVec0 = float3(u_xlat0_d.xy,u_xlat0_d.z);
          
          u_xlat0_d.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
          
          u_xlat4 = (-_LightShadowData.x) + 1.0;
          
          u_xlat0_d = u_xlat0_d.xxxx * float4(u_xlat4) + _LightShadowData.xxxx;
          
          out_f.color = u_xlat0_d;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
  }
  SubShader
  {
    Tags
    { 
      "ShadowmapFilter" = "HardShadow_FORCE_INV_PROJECTION_IN_PS"
    }
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "ShadowmapFilter" = "HardShadow_FORCE_INV_PROJECTION_IN_PS"
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
      
      uniform float4 unity_CameraInvProjection[4];
      
      uniform float4 unity_ObjectToWorld[4];
      
      uniform float4 unity_MatrixVP[4];
      
      uniform float4 unity_CameraToWorld[4];
      
      uniform float4 _LightSplitsNear;
      
      uniform float4 _LightSplitsFar;
      
      uniform float4 unity_WorldToShadow[16];
      
      uniform float4 _LightShadowData;
      
      uniform sampler2D _CameraDepthTexture;
      
      uniform sampler2D _ShadowMapTexture;
      
      uniform sampler2D hlslcc_zcmp_ShadowMapTexture;
      
      
      
      struct appdata_t
      {
          
          float4 vertex : POSITION0;
          
          float2 texcoord : TEXCOORD0;
          
          float3 texcoord1 : TEXCOORD1;
      
      };
      
      
      struct OUT_Data_Vert
      {
          
          float4 texcoord : TEXCOORD0;
          
          float3 texcoord1 : TEXCOORD1;
          
          float3 texcoord2 : TEXCOORD2;
          
          float3 texcoord3 : TEXCOORD3;
          
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
      
      float3 u_xlat2;
      
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
          
          u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
          
          u_xlat1.xzw = u_xlat0.xwy * float3(0.5, 0.5, 0.5);
          
          u_xlat2.xyz = u_xlat0.yyy * unity_CameraInvProjection[1].xyz;
          
          u_xlat0.xyz = unity_CameraInvProjection[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
          
          out_v.texcoord.zw = u_xlat1.zz + u_xlat1.xw;
          
          out_v.texcoord.xy = in_v.texcoord.xy;
          
          out_v.texcoord1.xyz = in_v.texcoord1.xyz;
          
          u_xlat1.xyz = u_xlat0.xyz + (-unity_CameraInvProjection[2].xyz);
          
          u_xlat0.xyz = u_xlat0.xyz + unity_CameraInvProjection[2].xyz;
          
          u_xlat0.xyz = u_xlat0.xyz + unity_CameraInvProjection[3].xyz;
          
          u_xlat1.xyz = u_xlat1.xyz + unity_CameraInvProjection[3].xyz;
          
          u_xlat1.w = (-u_xlat1.z);
          
          out_v.texcoord2.xyz = u_xlat1.xyw;
          
          u_xlat0.w = (-u_xlat0.z);
          
          out_v.texcoord3.xyz = u_xlat0.xyw;
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float4 u_xlat0_d;
      
      float4 u_xlat1_d;
      
      float4 u_xlat16_1;
      
      bool4 u_xlatb1;
      
      float4 u_xlat2_d;
      
      bool4 u_xlatb2;
      
      float3 u_xlat3;
      
      float u_xlat4;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat0_d.z = texture(_CameraDepthTexture, in_f.texcoord.xy).x;
          
          u_xlat0_d.xy = in_f.texcoord.zw;
          
          u_xlat0_d.xyz = u_xlat0_d.xyz * float3(2.0, 2.0, 2.0) + float3(-1.0, -1.0, -1.0);
          
          u_xlat1_d = u_xlat0_d.yyyy * unity_CameraInvProjection[1];
          
          u_xlat1_d = unity_CameraInvProjection[0] * u_xlat0_d.xxxx + u_xlat1_d;
          
          u_xlat0_d = unity_CameraInvProjection[2] * u_xlat0_d.zzzz + u_xlat1_d;
          
          u_xlat0_d = u_xlat0_d + unity_CameraInvProjection[3];
          
          u_xlat0_d.xyz = u_xlat0_d.xyz / u_xlat0_d.www;
          
          u_xlatb1 = greaterThanEqual((-u_xlat0_d.zzzz), _LightSplitsNear);
          
          u_xlat1_d.x = u_xlatb1.x ? float(1.0) : 0.0;
          
          u_xlat1_d.y = u_xlatb1.y ? float(1.0) : 0.0;
          
          u_xlat1_d.z = u_xlatb1.z ? float(1.0) : 0.0;
          
          u_xlat1_d.w = u_xlatb1.w ? float(1.0) : 0.0;
      
      ;
          
          u_xlatb2 = lessThan((-u_xlat0_d.zzzz), _LightSplitsFar);
          
          u_xlat2_d.x = u_xlatb2.x ? float(1.0) : 0.0;
          
          u_xlat2_d.y = u_xlatb2.y ? float(1.0) : 0.0;
          
          u_xlat2_d.z = u_xlatb2.z ? float(1.0) : 0.0;
          
          u_xlat2_d.w = u_xlatb2.w ? float(1.0) : 0.0;
      
      ;
          
          u_xlat16_1 = u_xlat1_d * u_xlat2_d;
          
          u_xlat2_d = u_xlat0_d.yyyy * unity_CameraToWorld[1];
          
          u_xlat2_d = unity_CameraToWorld[0] * u_xlat0_d.xxxx + u_xlat2_d;
          
          u_xlat0_d = unity_CameraToWorld[2] * (-u_xlat0_d.zzzz) + u_xlat2_d;
          
          u_xlat0_d = u_xlat0_d + unity_CameraToWorld[3];
          
          u_xlat2_d.xyz = u_xlat0_d.yyy * unity_WorldToShadow[5].xyz;
          
          u_xlat2_d.xyz = unity_WorldToShadow[4].xyz * u_xlat0_d.xxx + u_xlat2_d.xyz;
          
          u_xlat2_d.xyz = unity_WorldToShadow[6].xyz * u_xlat0_d.zzz + u_xlat2_d.xyz;
          
          u_xlat2_d.xyz = unity_WorldToShadow[7].xyz * u_xlat0_d.www + u_xlat2_d.xyz;
          
          u_xlat2_d.xyz = u_xlat16_1.yyy * u_xlat2_d.xyz;
          
          u_xlat3.xyz = u_xlat0_d.yyy * unity_WorldToShadow[1].xyz;
          
          u_xlat3.xyz = unity_WorldToShadow[0].xyz * u_xlat0_d.xxx + u_xlat3.xyz;
          
          u_xlat3.xyz = unity_WorldToShadow[2].xyz * u_xlat0_d.zzz + u_xlat3.xyz;
          
          u_xlat3.xyz = unity_WorldToShadow[3].xyz * u_xlat0_d.www + u_xlat3.xyz;
          
          u_xlat2_d.xyz = u_xlat3.xyz * u_xlat16_1.xxx + u_xlat2_d.xyz;
          
          u_xlat3.xyz = u_xlat0_d.yyy * unity_WorldToShadow[9].xyz;
          
          u_xlat3.xyz = unity_WorldToShadow[8].xyz * u_xlat0_d.xxx + u_xlat3.xyz;
          
          u_xlat3.xyz = unity_WorldToShadow[10].xyz * u_xlat0_d.zzz + u_xlat3.xyz;
          
          u_xlat3.xyz = unity_WorldToShadow[11].xyz * u_xlat0_d.www + u_xlat3.xyz;
          
          u_xlat2_d.xyz = u_xlat3.xyz * u_xlat16_1.zzz + u_xlat2_d.xyz;
          
          u_xlat3.xyz = u_xlat0_d.yyy * unity_WorldToShadow[13].xyz;
          
          u_xlat3.xyz = unity_WorldToShadow[12].xyz * u_xlat0_d.xxx + u_xlat3.xyz;
          
          u_xlat0_d.xyz = unity_WorldToShadow[14].xyz * u_xlat0_d.zzz + u_xlat3.xyz;
          
          u_xlat0_d.xyz = unity_WorldToShadow[15].xyz * u_xlat0_d.www + u_xlat0_d.xyz;
          
          u_xlat0_d.xyz = u_xlat0_d.xyz * u_xlat16_1.www + u_xlat2_d.xyz;
          
          float3 txVec0 = float3(u_xlat0_d.xy,u_xlat0_d.z);
          
          u_xlat0_d.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
          
          u_xlat4 = (-_LightShadowData.x) + 1.0;
          
          u_xlat0_d = u_xlat0_d.xxxx * float4(u_xlat4) + _LightShadowData.xxxx;
          
          out_f.color = u_xlat0_d;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
  }
  SubShader
  {
    Tags
    { 
      "ShadowmapFilter" = "PCF_SOFT"
    }
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "ShadowmapFilter" = "PCF_SOFT"
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
      
      uniform float4 unity_CameraInvProjection[4];
      
      uniform float4 unity_ObjectToWorld[4];
      
      uniform float4 unity_MatrixVP[4];
      
      uniform float4 _ZBufferParams;
      
      uniform float4 unity_OrthoParams;
      
      uniform float4 unity_CameraToWorld[4];
      
      uniform float4 _LightSplitsNear;
      
      uniform float4 _LightSplitsFar;
      
      uniform float4 unity_WorldToShadow[16];
      
      uniform float4 _LightShadowData;
      
      uniform float4 _ShadowMapTexture_TexelSize;
      
      uniform sampler2D _CameraDepthTexture;
      
      uniform sampler2D _ShadowMapTexture;
      
      uniform sampler2D hlslcc_zcmp_ShadowMapTexture;
      
      
      
      struct appdata_t
      {
          
          float4 vertex : POSITION0;
          
          float2 texcoord : TEXCOORD0;
          
          float3 texcoord1 : TEXCOORD1;
      
      };
      
      
      struct OUT_Data_Vert
      {
          
          float4 texcoord : TEXCOORD0;
          
          float3 texcoord1 : TEXCOORD1;
          
          float3 texcoord2 : TEXCOORD2;
          
          float3 texcoord3 : TEXCOORD3;
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float4 texcoord : TEXCOORD0;
          
          float3 texcoord1 : TEXCOORD1;
          
          float3 texcoord2 : TEXCOORD2;
          
          float3 texcoord3 : TEXCOORD3;
      
      };
      
      
      struct OUT_Data_Frag
      {
          
          float4 color : SV_Target0;
      
      };
      
      
      float4 u_xlat0;
      
      float4 u_xlat1;
      
      float3 u_xlat2;
      
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
          
          u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
          
          u_xlat1.xzw = u_xlat0.xwy * float3(0.5, 0.5, 0.5);
          
          u_xlat2.xyz = u_xlat0.yyy * unity_CameraInvProjection[1].xyz;
          
          u_xlat0.xyz = unity_CameraInvProjection[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
          
          out_v.texcoord.zw = u_xlat1.zz + u_xlat1.xw;
          
          out_v.texcoord.xy = in_v.texcoord.xy;
          
          out_v.texcoord1.xyz = in_v.texcoord1.xyz;
          
          u_xlat1.xyz = u_xlat0.xyz + (-unity_CameraInvProjection[2].xyz);
          
          u_xlat0.xyz = u_xlat0.xyz + unity_CameraInvProjection[2].xyz;
          
          u_xlat0.xyz = u_xlat0.xyz + unity_CameraInvProjection[3].xyz;
          
          u_xlat1.xyz = u_xlat1.xyz + unity_CameraInvProjection[3].xyz;
          
          u_xlat1.w = (-u_xlat1.z);
          
          out_v.texcoord2.xyz = u_xlat1.xyw;
          
          u_xlat0.w = (-u_xlat0.z);
          
          out_v.texcoord3.xyz = u_xlat0.xyw;
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float4 u_xlat0_d;
      
      float4 u_xlat1_d;
      
      float4 u_xlat16_1;
      
      bool4 u_xlatb1;
      
      float4 u_xlat2_d;
      
      bool4 u_xlatb2;
      
      float4 u_xlat3;
      
      float4 u_xlat4;
      
      float4 u_xlat5;
      
      float4 u_xlat6;
      
      float u_xlat7;
      
      float u_xlat9;
      
      float u_xlat14;
      
      float2 u_xlat16;
      
      float u_xlat21;
      
      float u_xlat23;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat0_d.x = texture(_CameraDepthTexture, in_f.texcoord.xy).x;
          
          u_xlat7 = _ZBufferParams.x * u_xlat0_d.x + _ZBufferParams.y;
          
          u_xlat7 = float(1.0) / u_xlat7;
          
          u_xlat14 = (-u_xlat7) + u_xlat0_d.x;
          
          u_xlat7 = unity_OrthoParams.w * u_xlat14 + u_xlat7;
          
          u_xlat1_d.xyz = (-in_f.texcoord2.xyz) + in_f.texcoord3.xyz;
          
          u_xlat0_d.xzw = u_xlat0_d.xxx * u_xlat1_d.xyz + in_f.texcoord2.xyz;
          
          u_xlat0_d.xzw = (-in_f.texcoord1.xyz) * float3(u_xlat7) + u_xlat0_d.xzw;
          
          u_xlat1_d.xyz = float3(u_xlat7) * in_f.texcoord1.xyz;
          
          u_xlat0_d.xyz = unity_OrthoParams.www * u_xlat0_d.xzw + u_xlat1_d.xyz;
          
          u_xlatb1 = greaterThanEqual(u_xlat0_d.zzzz, _LightSplitsNear);
          
          u_xlat1_d.x = u_xlatb1.x ? float(1.0) : 0.0;
          
          u_xlat1_d.y = u_xlatb1.y ? float(1.0) : 0.0;
          
          u_xlat1_d.z = u_xlatb1.z ? float(1.0) : 0.0;
          
          u_xlat1_d.w = u_xlatb1.w ? float(1.0) : 0.0;
      
      ;
          
          u_xlatb2 = lessThan(u_xlat0_d.zzzz, _LightSplitsFar);
          
          u_xlat2_d.x = u_xlatb2.x ? float(1.0) : 0.0;
          
          u_xlat2_d.y = u_xlatb2.y ? float(1.0) : 0.0;
          
          u_xlat2_d.z = u_xlatb2.z ? float(1.0) : 0.0;
          
          u_xlat2_d.w = u_xlatb2.w ? float(1.0) : 0.0;
      
      ;
          
          u_xlat16_1 = u_xlat1_d * u_xlat2_d;
          
          u_xlat2_d = u_xlat0_d.yyyy * unity_CameraToWorld[1];
          
          u_xlat2_d = unity_CameraToWorld[0] * u_xlat0_d.xxxx + u_xlat2_d;
          
          u_xlat0_d = unity_CameraToWorld[2] * u_xlat0_d.zzzz + u_xlat2_d;
          
          u_xlat0_d = u_xlat0_d + unity_CameraToWorld[3];
          
          u_xlat2_d.xyz = u_xlat0_d.yyy * unity_WorldToShadow[5].xyz;
          
          u_xlat2_d.xyz = unity_WorldToShadow[4].xyz * u_xlat0_d.xxx + u_xlat2_d.xyz;
          
          u_xlat2_d.xyz = unity_WorldToShadow[6].xyz * u_xlat0_d.zzz + u_xlat2_d.xyz;
          
          u_xlat2_d.xyz = unity_WorldToShadow[7].xyz * u_xlat0_d.www + u_xlat2_d.xyz;
          
          u_xlat2_d.xyz = u_xlat16_1.yyy * u_xlat2_d.xyz;
          
          u_xlat3.xyz = u_xlat0_d.yyy * unity_WorldToShadow[1].xyz;
          
          u_xlat3.xyz = unity_WorldToShadow[0].xyz * u_xlat0_d.xxx + u_xlat3.xyz;
          
          u_xlat3.xyz = unity_WorldToShadow[2].xyz * u_xlat0_d.zzz + u_xlat3.xyz;
          
          u_xlat3.xyz = unity_WorldToShadow[3].xyz * u_xlat0_d.www + u_xlat3.xyz;
          
          u_xlat2_d.xyz = u_xlat3.xyz * u_xlat16_1.xxx + u_xlat2_d.xyz;
          
          u_xlat3.xyz = u_xlat0_d.yyy * unity_WorldToShadow[9].xyz;
          
          u_xlat3.xyz = unity_WorldToShadow[8].xyz * u_xlat0_d.xxx + u_xlat3.xyz;
          
          u_xlat3.xyz = unity_WorldToShadow[10].xyz * u_xlat0_d.zzz + u_xlat3.xyz;
          
          u_xlat3.xyz = unity_WorldToShadow[11].xyz * u_xlat0_d.www + u_xlat3.xyz;
          
          u_xlat2_d.xyz = u_xlat3.xyz * u_xlat16_1.zzz + u_xlat2_d.xyz;
          
          u_xlat3.xyz = u_xlat0_d.yyy * unity_WorldToShadow[13].xyz;
          
          u_xlat3.xyz = unity_WorldToShadow[12].xyz * u_xlat0_d.xxx + u_xlat3.xyz;
          
          u_xlat0_d.xyz = unity_WorldToShadow[14].xyz * u_xlat0_d.zzz + u_xlat3.xyz;
          
          u_xlat0_d.xyz = unity_WorldToShadow[15].xyz * u_xlat0_d.www + u_xlat0_d.xyz;
          
          u_xlat0_d.xyz = u_xlat0_d.xyz * u_xlat16_1.www + u_xlat2_d.xyz;
          
          u_xlat2_d.xy = u_xlat0_d.xy * _ShadowMapTexture_TexelSize.zw + float2(0.5, 0.5);
          
          u_xlat2_d.xy = floor(u_xlat2_d.xy);
          
          u_xlat0_d.xy = u_xlat0_d.xy * _ShadowMapTexture_TexelSize.zw + (-u_xlat2_d.xy);
          
          u_xlat16.xy = min(u_xlat0_d.xy, float2(0.0, 0.0));
          
          u_xlat3.xy = (-u_xlat0_d.xy) + float2(1.0, 1.0);
          
          u_xlat16.xy = (-u_xlat16.xy) * u_xlat16.xy + u_xlat3.xy;
          
          u_xlat1_d.xy = u_xlat3.xy * float2(0.159999996, 0.159999996);
          
          u_xlat16.xy = u_xlat16.xy + float2(1.0, 1.0);
          
          u_xlat3.xy = u_xlat16.xy * float2(0.159999996, 0.159999996);
          
          u_xlat16.xy = max(u_xlat0_d.xy, float2(0.0, 0.0));
          
          u_xlat4 = u_xlat0_d.xxyy + float4(0.5, 1.0, 0.5, 1.0);
          
          u_xlat16.xy = (-u_xlat16.xy) * u_xlat16.xy + u_xlat4.yw;
          
          u_xlat16.xy = u_xlat16.xy + float2(1.0, 1.0);
          
          u_xlat5.xy = u_xlat16.xy * float2(0.159999996, 0.159999996);
          
          u_xlat6 = u_xlat4.xxzz * u_xlat4.xxzz;
          
          u_xlat16.xy = u_xlat4.yw * float2(0.159999996, 0.159999996);
          
          u_xlat0_d.xy = u_xlat6.xz * float2(0.5, 0.5) + (-u_xlat0_d.xy);
          
          u_xlat1_d.zw = u_xlat6.wy * float2(0.0799999982, 0.0799999982);
          
          u_xlat4.xy = u_xlat0_d.xy * float2(0.159999996, 0.159999996);
          
          u_xlat3.z = u_xlat4.y;
          
          u_xlat3.w = u_xlat16.y;
          
          u_xlat4.w = u_xlat16.x;
          
          u_xlat5.zw = u_xlat1_d.yz;
          
          u_xlat0_d.xyw = u_xlat3.zyw + u_xlat5.zyw;
          
          u_xlat4.z = u_xlat3.x;
          
          u_xlat3.xyz = u_xlat5.zyw / u_xlat0_d.xyw;
          
          u_xlat1_d.z = u_xlat5.x;
          
          u_xlat3.xyz = u_xlat3.xyz + float3(-2.5, -0.5, 1.5);
          
          u_xlat3.xyz = u_xlat3.xyz * _ShadowMapTexture_TexelSize.yyy;
          
          u_xlat5.w = u_xlat3.x;
          
          u_xlat4 = u_xlat1_d.zwxz + u_xlat4.zwxz;
          
          u_xlat6.xyz = u_xlat1_d.xzw / u_xlat4.zwy;
          
          u_xlat6.xyz = u_xlat6.xyz + float3(-2.5, -0.5, 1.5);
          
          u_xlat5.xyz = u_xlat6.yxz * _ShadowMapTexture_TexelSize.xxx;
          
          u_xlat1_d = u_xlat2_d.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.ywxw;
          
          u_xlat16.xy = u_xlat2_d.xy * _ShadowMapTexture_TexelSize.xy + u_xlat5.zw;
          
          float3 txVec0 = float3(u_xlat16.xy,u_xlat0_d.z);
          
          u_xlat16.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
          
          float3 txVec1 = float3(u_xlat1_d.xy,u_xlat0_d.z);
          
          u_xlat23 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
          
          float3 txVec2 = float3(u_xlat1_d.zw,u_xlat0_d.z);
          
          u_xlat3.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
          
          u_xlat1_d = u_xlat0_d.xxxy * u_xlat4.zwyz;
          
          u_xlat0_d.x = u_xlat3.x * u_xlat1_d.y;
          
          u_xlat0_d.x = u_xlat1_d.x * u_xlat23 + u_xlat0_d.x;
          
          u_xlat0_d.x = u_xlat1_d.z * u_xlat16.x + u_xlat0_d.x;
          
          u_xlat3.w = u_xlat5.y;
          
          u_xlat6 = u_xlat2_d.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.wywz;
          
          u_xlat5.yw = u_xlat3.yz;
          
          float3 txVec3 = float3(u_xlat6.xy,u_xlat0_d.z);
          
          u_xlat16.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
          
          float3 txVec4 = float3(u_xlat6.zw,u_xlat0_d.z);
          
          u_xlat23 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec4, 0.0);
          
          u_xlat0_d.x = u_xlat1_d.w * u_xlat16.x + u_xlat0_d.x;
          
          u_xlat1_d = u_xlat2_d.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xyzy;
          
          u_xlat3 = u_xlat2_d.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xwzw;
          
          float3 txVec5 = float3(u_xlat1_d.xy,u_xlat0_d.z);
          
          u_xlat2_d.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec5, 0.0);
          
          float3 txVec6 = float3(u_xlat1_d.zw,u_xlat0_d.z);
          
          u_xlat9 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec6, 0.0);
          
          u_xlat1_d = u_xlat0_d.yyww * u_xlat4;
          
          u_xlat7 = u_xlat0_d.w * u_xlat4.y;
          
          u_xlat0_d.x = u_xlat1_d.x * u_xlat2_d.x + u_xlat0_d.x;
          
          u_xlat0_d.x = u_xlat1_d.y * u_xlat9 + u_xlat0_d.x;
          
          u_xlat0_d.x = u_xlat1_d.z * u_xlat23 + u_xlat0_d.x;
          
          float3 txVec7 = float3(u_xlat3.xy,u_xlat0_d.z);
          
          u_xlat21 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec7, 0.0);
          
          float3 txVec8 = float3(u_xlat3.zw,u_xlat0_d.z);
          
          u_xlat14 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec8, 0.0);
          
          u_xlat0_d.x = u_xlat1_d.w * u_xlat21 + u_xlat0_d.x;
          
          u_xlat0_d.x = u_xlat7 * u_xlat14 + u_xlat0_d.x;
          
          u_xlat7 = (-_LightShadowData.x) + 1.0;
          
          u_xlat0_d = u_xlat0_d.xxxx * float4(u_xlat7) + _LightShadowData.xxxx;
          
          out_f.color = u_xlat0_d;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
  }
  SubShader
  {
    Tags
    { 
      "ShadowmapFilter" = "PCF_SOFT_FORCE_INV_PROJECTION_IN_PS"
    }
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "ShadowmapFilter" = "PCF_SOFT_FORCE_INV_PROJECTION_IN_PS"
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
      
      uniform float4 unity_CameraInvProjection[4];
      
      uniform float4 unity_ObjectToWorld[4];
      
      uniform float4 unity_MatrixVP[4];
      
      uniform float4 unity_CameraToWorld[4];
      
      uniform float4 _LightSplitsNear;
      
      uniform float4 _LightSplitsFar;
      
      uniform float4 unity_WorldToShadow[16];
      
      uniform float4 _LightShadowData;
      
      uniform float4 _ShadowMapTexture_TexelSize;
      
      uniform sampler2D _CameraDepthTexture;
      
      uniform sampler2D _ShadowMapTexture;
      
      uniform sampler2D hlslcc_zcmp_ShadowMapTexture;
      
      
      
      struct appdata_t
      {
          
          float4 vertex : POSITION0;
          
          float2 texcoord : TEXCOORD0;
          
          float3 texcoord1 : TEXCOORD1;
      
      };
      
      
      struct OUT_Data_Vert
      {
          
          float4 texcoord : TEXCOORD0;
          
          float3 texcoord1 : TEXCOORD1;
          
          float3 texcoord2 : TEXCOORD2;
          
          float3 texcoord3 : TEXCOORD3;
          
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
      
      float3 u_xlat2;
      
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
          
          u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
          
          u_xlat1.xzw = u_xlat0.xwy * float3(0.5, 0.5, 0.5);
          
          u_xlat2.xyz = u_xlat0.yyy * unity_CameraInvProjection[1].xyz;
          
          u_xlat0.xyz = unity_CameraInvProjection[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
          
          out_v.texcoord.zw = u_xlat1.zz + u_xlat1.xw;
          
          out_v.texcoord.xy = in_v.texcoord.xy;
          
          out_v.texcoord1.xyz = in_v.texcoord1.xyz;
          
          u_xlat1.xyz = u_xlat0.xyz + (-unity_CameraInvProjection[2].xyz);
          
          u_xlat0.xyz = u_xlat0.xyz + unity_CameraInvProjection[2].xyz;
          
          u_xlat0.xyz = u_xlat0.xyz + unity_CameraInvProjection[3].xyz;
          
          u_xlat1.xyz = u_xlat1.xyz + unity_CameraInvProjection[3].xyz;
          
          u_xlat1.w = (-u_xlat1.z);
          
          out_v.texcoord2.xyz = u_xlat1.xyw;
          
          u_xlat0.w = (-u_xlat0.z);
          
          out_v.texcoord3.xyz = u_xlat0.xyw;
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float4 u_xlat0_d;
      
      float4 u_xlat1_d;
      
      float4 u_xlat16_1;
      
      bool4 u_xlatb1;
      
      float4 u_xlat2_d;
      
      bool4 u_xlatb2;
      
      float4 u_xlat3;
      
      float4 u_xlat4;
      
      float4 u_xlat5;
      
      float4 u_xlat6;
      
      float u_xlat7;
      
      float u_xlat9;
      
      float u_xlat14;
      
      float2 u_xlat16;
      
      float u_xlat21;
      
      float u_xlat23;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat0_d.z = texture(_CameraDepthTexture, in_f.texcoord.xy).x;
          
          u_xlat0_d.xy = in_f.texcoord.zw;
          
          u_xlat0_d.xyz = u_xlat0_d.xyz * float3(2.0, 2.0, 2.0) + float3(-1.0, -1.0, -1.0);
          
          u_xlat1_d = u_xlat0_d.yyyy * unity_CameraInvProjection[1];
          
          u_xlat1_d = unity_CameraInvProjection[0] * u_xlat0_d.xxxx + u_xlat1_d;
          
          u_xlat0_d = unity_CameraInvProjection[2] * u_xlat0_d.zzzz + u_xlat1_d;
          
          u_xlat0_d = u_xlat0_d + unity_CameraInvProjection[3];
          
          u_xlat0_d.xyz = u_xlat0_d.xyz / u_xlat0_d.www;
          
          u_xlatb1 = greaterThanEqual((-u_xlat0_d.zzzz), _LightSplitsNear);
          
          u_xlat1_d.x = u_xlatb1.x ? float(1.0) : 0.0;
          
          u_xlat1_d.y = u_xlatb1.y ? float(1.0) : 0.0;
          
          u_xlat1_d.z = u_xlatb1.z ? float(1.0) : 0.0;
          
          u_xlat1_d.w = u_xlatb1.w ? float(1.0) : 0.0;
      
      ;
          
          u_xlatb2 = lessThan((-u_xlat0_d.zzzz), _LightSplitsFar);
          
          u_xlat2_d.x = u_xlatb2.x ? float(1.0) : 0.0;
          
          u_xlat2_d.y = u_xlatb2.y ? float(1.0) : 0.0;
          
          u_xlat2_d.z = u_xlatb2.z ? float(1.0) : 0.0;
          
          u_xlat2_d.w = u_xlatb2.w ? float(1.0) : 0.0;
      
      ;
          
          u_xlat16_1 = u_xlat1_d * u_xlat2_d;
          
          u_xlat2_d = u_xlat0_d.yyyy * unity_CameraToWorld[1];
          
          u_xlat2_d = unity_CameraToWorld[0] * u_xlat0_d.xxxx + u_xlat2_d;
          
          u_xlat0_d = unity_CameraToWorld[2] * (-u_xlat0_d.zzzz) + u_xlat2_d;
          
          u_xlat0_d = u_xlat0_d + unity_CameraToWorld[3];
          
          u_xlat2_d.xyz = u_xlat0_d.yyy * unity_WorldToShadow[5].xyz;
          
          u_xlat2_d.xyz = unity_WorldToShadow[4].xyz * u_xlat0_d.xxx + u_xlat2_d.xyz;
          
          u_xlat2_d.xyz = unity_WorldToShadow[6].xyz * u_xlat0_d.zzz + u_xlat2_d.xyz;
          
          u_xlat2_d.xyz = unity_WorldToShadow[7].xyz * u_xlat0_d.www + u_xlat2_d.xyz;
          
          u_xlat2_d.xyz = u_xlat16_1.yyy * u_xlat2_d.xyz;
          
          u_xlat3.xyz = u_xlat0_d.yyy * unity_WorldToShadow[1].xyz;
          
          u_xlat3.xyz = unity_WorldToShadow[0].xyz * u_xlat0_d.xxx + u_xlat3.xyz;
          
          u_xlat3.xyz = unity_WorldToShadow[2].xyz * u_xlat0_d.zzz + u_xlat3.xyz;
          
          u_xlat3.xyz = unity_WorldToShadow[3].xyz * u_xlat0_d.www + u_xlat3.xyz;
          
          u_xlat2_d.xyz = u_xlat3.xyz * u_xlat16_1.xxx + u_xlat2_d.xyz;
          
          u_xlat3.xyz = u_xlat0_d.yyy * unity_WorldToShadow[9].xyz;
          
          u_xlat3.xyz = unity_WorldToShadow[8].xyz * u_xlat0_d.xxx + u_xlat3.xyz;
          
          u_xlat3.xyz = unity_WorldToShadow[10].xyz * u_xlat0_d.zzz + u_xlat3.xyz;
          
          u_xlat3.xyz = unity_WorldToShadow[11].xyz * u_xlat0_d.www + u_xlat3.xyz;
          
          u_xlat2_d.xyz = u_xlat3.xyz * u_xlat16_1.zzz + u_xlat2_d.xyz;
          
          u_xlat3.xyz = u_xlat0_d.yyy * unity_WorldToShadow[13].xyz;
          
          u_xlat3.xyz = unity_WorldToShadow[12].xyz * u_xlat0_d.xxx + u_xlat3.xyz;
          
          u_xlat0_d.xyz = unity_WorldToShadow[14].xyz * u_xlat0_d.zzz + u_xlat3.xyz;
          
          u_xlat0_d.xyz = unity_WorldToShadow[15].xyz * u_xlat0_d.www + u_xlat0_d.xyz;
          
          u_xlat0_d.xyz = u_xlat0_d.xyz * u_xlat16_1.www + u_xlat2_d.xyz;
          
          u_xlat2_d.xy = u_xlat0_d.xy * _ShadowMapTexture_TexelSize.zw + float2(0.5, 0.5);
          
          u_xlat2_d.xy = floor(u_xlat2_d.xy);
          
          u_xlat0_d.xy = u_xlat0_d.xy * _ShadowMapTexture_TexelSize.zw + (-u_xlat2_d.xy);
          
          u_xlat16.xy = min(u_xlat0_d.xy, float2(0.0, 0.0));
          
          u_xlat3.xy = (-u_xlat0_d.xy) + float2(1.0, 1.0);
          
          u_xlat16.xy = (-u_xlat16.xy) * u_xlat16.xy + u_xlat3.xy;
          
          u_xlat1_d.xy = u_xlat3.xy * float2(0.159999996, 0.159999996);
          
          u_xlat16.xy = u_xlat16.xy + float2(1.0, 1.0);
          
          u_xlat3.xy = u_xlat16.xy * float2(0.159999996, 0.159999996);
          
          u_xlat16.xy = max(u_xlat0_d.xy, float2(0.0, 0.0));
          
          u_xlat4 = u_xlat0_d.xxyy + float4(0.5, 1.0, 0.5, 1.0);
          
          u_xlat16.xy = (-u_xlat16.xy) * u_xlat16.xy + u_xlat4.yw;
          
          u_xlat16.xy = u_xlat16.xy + float2(1.0, 1.0);
          
          u_xlat5.xy = u_xlat16.xy * float2(0.159999996, 0.159999996);
          
          u_xlat6 = u_xlat4.xxzz * u_xlat4.xxzz;
          
          u_xlat16.xy = u_xlat4.yw * float2(0.159999996, 0.159999996);
          
          u_xlat0_d.xy = u_xlat6.xz * float2(0.5, 0.5) + (-u_xlat0_d.xy);
          
          u_xlat1_d.zw = u_xlat6.wy * float2(0.0799999982, 0.0799999982);
          
          u_xlat4.xy = u_xlat0_d.xy * float2(0.159999996, 0.159999996);
          
          u_xlat3.z = u_xlat4.y;
          
          u_xlat3.w = u_xlat16.y;
          
          u_xlat4.w = u_xlat16.x;
          
          u_xlat5.zw = u_xlat1_d.yz;
          
          u_xlat0_d.xyw = u_xlat3.zyw + u_xlat5.zyw;
          
          u_xlat4.z = u_xlat3.x;
          
          u_xlat3.xyz = u_xlat5.zyw / u_xlat0_d.xyw;
          
          u_xlat1_d.z = u_xlat5.x;
          
          u_xlat3.xyz = u_xlat3.xyz + float3(-2.5, -0.5, 1.5);
          
          u_xlat3.xyz = u_xlat3.xyz * _ShadowMapTexture_TexelSize.yyy;
          
          u_xlat5.w = u_xlat3.x;
          
          u_xlat4 = u_xlat1_d.zwxz + u_xlat4.zwxz;
          
          u_xlat6.xyz = u_xlat1_d.xzw / u_xlat4.zwy;
          
          u_xlat6.xyz = u_xlat6.xyz + float3(-2.5, -0.5, 1.5);
          
          u_xlat5.xyz = u_xlat6.yxz * _ShadowMapTexture_TexelSize.xxx;
          
          u_xlat1_d = u_xlat2_d.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.ywxw;
          
          u_xlat16.xy = u_xlat2_d.xy * _ShadowMapTexture_TexelSize.xy + u_xlat5.zw;
          
          float3 txVec0 = float3(u_xlat16.xy,u_xlat0_d.z);
          
          u_xlat16.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
          
          float3 txVec1 = float3(u_xlat1_d.xy,u_xlat0_d.z);
          
          u_xlat23 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
          
          float3 txVec2 = float3(u_xlat1_d.zw,u_xlat0_d.z);
          
          u_xlat3.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
          
          u_xlat1_d = u_xlat0_d.xxxy * u_xlat4.zwyz;
          
          u_xlat0_d.x = u_xlat3.x * u_xlat1_d.y;
          
          u_xlat0_d.x = u_xlat1_d.x * u_xlat23 + u_xlat0_d.x;
          
          u_xlat0_d.x = u_xlat1_d.z * u_xlat16.x + u_xlat0_d.x;
          
          u_xlat3.w = u_xlat5.y;
          
          u_xlat6 = u_xlat2_d.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.wywz;
          
          u_xlat5.yw = u_xlat3.yz;
          
          float3 txVec3 = float3(u_xlat6.xy,u_xlat0_d.z);
          
          u_xlat16.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
          
          float3 txVec4 = float3(u_xlat6.zw,u_xlat0_d.z);
          
          u_xlat23 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec4, 0.0);
          
          u_xlat0_d.x = u_xlat1_d.w * u_xlat16.x + u_xlat0_d.x;
          
          u_xlat1_d = u_xlat2_d.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xyzy;
          
          u_xlat3 = u_xlat2_d.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xwzw;
          
          float3 txVec5 = float3(u_xlat1_d.xy,u_xlat0_d.z);
          
          u_xlat2_d.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec5, 0.0);
          
          float3 txVec6 = float3(u_xlat1_d.zw,u_xlat0_d.z);
          
          u_xlat9 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec6, 0.0);
          
          u_xlat1_d = u_xlat0_d.yyww * u_xlat4;
          
          u_xlat7 = u_xlat0_d.w * u_xlat4.y;
          
          u_xlat0_d.x = u_xlat1_d.x * u_xlat2_d.x + u_xlat0_d.x;
          
          u_xlat0_d.x = u_xlat1_d.y * u_xlat9 + u_xlat0_d.x;
          
          u_xlat0_d.x = u_xlat1_d.z * u_xlat23 + u_xlat0_d.x;
          
          float3 txVec7 = float3(u_xlat3.xy,u_xlat0_d.z);
          
          u_xlat21 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec7, 0.0);
          
          float3 txVec8 = float3(u_xlat3.zw,u_xlat0_d.z);
          
          u_xlat14 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec8, 0.0);
          
          u_xlat0_d.x = u_xlat1_d.w * u_xlat21 + u_xlat0_d.x;
          
          u_xlat0_d.x = u_xlat7 * u_xlat14 + u_xlat0_d.x;
          
          u_xlat7 = (-_LightShadowData.x) + 1.0;
          
          u_xlat0_d = u_xlat0_d.xxxx * float4(u_xlat7) + _LightShadowData.xxxx;
          
          out_f.color = u_xlat0_d;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
