Shader "Hidden/Internal-DeferredReflections"
{
  Properties
  {
    _SrcBlend ("", float) = 1
    _DstBlend ("", float) = 1
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
      ZWrite Off
      Blend Zero Zero
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      
      
      uniform float4 _ProjectionParams;
      
      uniform float4 unity_ObjectToWorld[4];
      
      uniform float4 unity_MatrixV[4];
      
      uniform float4 unity_MatrixVP[4];
      
      uniform float _LightAsQuad;
      
      uniform float3 _WorldSpaceCameraPos;
      
      uniform float4 _ZBufferParams;
      
      uniform float4 unity_CameraToWorld[4];
      
      uniform float4 unity_SpecCube0_BoxMax;
      
      uniform float4 unity_SpecCube0_BoxMin;
      
      uniform float4 unity_SpecCube0_HDR;
      
      uniform float4 unity_SpecCube1_ProbePosition;
      
      uniform sampler2D _CameraDepthTexture;
      
      uniform sampler2D _CameraGBufferTexture0;
      
      uniform sampler2D _CameraGBufferTexture1;
      
      uniform sampler2D _CameraGBufferTexture2;
      
      uniform samplerCUBE unity_SpecCube0;
      
      
      
      struct appdata_t
      {
          
          float4 vertex : POSITION0;
          
          float3 normal : NORMAL0;
      
      };
      
      
      struct OUT_Data_Vert
      {
          
          float4 texcoord : TEXCOORD0;
          
          float3 texcoord1 : TEXCOORD1;
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float4 texcoord : TEXCOORD0;
          
          float3 texcoord1 : TEXCOORD1;
      
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
          
          u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
          
          u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
          
          u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
          
          u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
          
          u_xlat1 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
          
          out_v.vertex = u_xlat1;
          
          u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
          
          u_xlat2.xzw = u_xlat1.xwy * float3(0.5, 0.5, 0.5);
          
          out_v.texcoord.zw = u_xlat1.zw;
          
          out_v.texcoord.xy = u_xlat2.zz + u_xlat2.xw;
          
          u_xlat1.xyz = u_xlat0.yyy * unity_MatrixV[1].xyz;
          
          u_xlat1.xyz = unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
          
          u_xlat0.xyz = unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
          
          u_xlat0.xyz = unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
          
          u_xlat1.xyz = u_xlat0.xyz * float3(-1.0, -1.0, 1.0);
          
          u_xlat0.xyz = (-u_xlat0.xyz) * float3(-1.0, -1.0, 1.0) + in_v.normal.xyz;
          
          out_v.texcoord1.xyz = float3(_LightAsQuad) * u_xlat0.xyz + u_xlat1.xyz;
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float4 u_xlat0_d;
      
      float2 u_xlat1_d;
      
      float u_xlat16_1;
      
      float3 u_xlat2_d;
      
      float4 u_xlat16_2;
      
      float3 u_xlat3;
      
      float3 u_xlat16_3;
      
      float4 u_xlat16_4;
      
      float3 u_xlat16_5;
      
      float3 u_xlat16_6;
      
      float u_xlat21;
      
      float u_xlat16_26;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat0_d.x = _ProjectionParams.z / in_f.texcoord1.z;
          
          u_xlat0_d.xyz = u_xlat0_d.xxx * in_f.texcoord1.xyz;
          
          u_xlat1_d.xy = in_f.texcoord.xy / in_f.texcoord.ww;
          
          u_xlat21 = texture(_CameraDepthTexture, u_xlat1_d.xy).x;
          
          u_xlat21 = _ZBufferParams.x * u_xlat21 + _ZBufferParams.y;
          
          u_xlat21 = float(1.0) / u_xlat21;
          
          u_xlat0_d.xyz = float3(u_xlat21) * u_xlat0_d.xyz;
          
          u_xlat2_d.xyz = u_xlat0_d.yyy * unity_CameraToWorld[1].xyz;
          
          u_xlat0_d.xyw = unity_CameraToWorld[0].xyz * u_xlat0_d.xxx + u_xlat2_d.xyz;
          
          u_xlat0_d.xyz = unity_CameraToWorld[2].xyz * u_xlat0_d.zzz + u_xlat0_d.xyw;
          
          u_xlat0_d.xyz = u_xlat0_d.xyz + unity_CameraToWorld[3].xyz;
          
          u_xlat2_d.xyz = u_xlat0_d.xyz + (-_WorldSpaceCameraPos.xyz);
          
          u_xlat21 = dot(u_xlat2_d.xyz, u_xlat2_d.xyz);
          
          u_xlat21 = inversesqrt(u_xlat21);
          
          u_xlat2_d.xyz = float3(u_xlat21) * u_xlat2_d.xyz;
          
          u_xlat16_3.xyz = texture(_CameraGBufferTexture2, u_xlat1_d.xy).xyz;
          
          u_xlat3.xyz = u_xlat16_3.xyz * float3(2.0, 2.0, 2.0) + float3(-1.0, -1.0, -1.0);
          
          u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
          
          u_xlat21 = inversesqrt(u_xlat21);
          
          u_xlat3.xyz = float3(u_xlat21) * u_xlat3.xyz;
          
          u_xlat21 = dot(u_xlat3.xyz, (-u_xlat2_d.xyz));
          
          u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
          
          u_xlat16_4.x = (-u_xlat21) + 1.0;
          
          u_xlat21 = u_xlat16_4.x * u_xlat16_4.x;
          
          u_xlat21 = u_xlat16_4.x * u_xlat21;
          
          u_xlat21 = u_xlat16_4.x * u_xlat21;
          
          u_xlat16_4 = texture(_CameraGBufferTexture1, u_xlat1_d.xy);
          
          u_xlat16_1 = texture(_CameraGBufferTexture0, u_xlat1_d.xy).w;
          
          u_xlat16_5.x = max(u_xlat16_4.y, u_xlat16_4.x);
          
          u_xlat16_5.x = max(u_xlat16_4.z, u_xlat16_5.x);
          
          u_xlat16_5.x = (-u_xlat16_5.x) + 1.0;
          
          u_xlat16_5.x = (-u_xlat16_5.x) + 1.0;
          
          u_xlat16_5.x = u_xlat16_4.w + u_xlat16_5.x;
          
          u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
          
          u_xlat16_5.xyz = (-u_xlat16_4.xyz) + u_xlat16_5.xxx;
          
          u_xlat16_5.xyz = float3(u_xlat21) * u_xlat16_5.xyz + u_xlat16_4.xyz;
          
          u_xlat21 = (-u_xlat16_4.w) + 1.0;
          
          u_xlat16_26 = (-u_xlat21) * 0.699999988 + 1.70000005;
          
          u_xlat16_26 = u_xlat21 * u_xlat16_26;
          
          u_xlat16_26 = u_xlat16_26 * 6.0;
          
          u_xlat16_6.x = dot(u_xlat2_d.xyz, u_xlat3.xyz);
          
          u_xlat16_6.x = u_xlat16_6.x + u_xlat16_6.x;
          
          u_xlat16_6.xyz = u_xlat3.xyz * (-u_xlat16_6.xxx) + u_xlat2_d.xyz;
          
          u_xlat16_2 = textureLod(unity_SpecCube0, u_xlat16_6.xyz, u_xlat16_26);
          
          u_xlat16_26 = u_xlat16_2.w + -1.0;
          
          u_xlat16_26 = unity_SpecCube0_HDR.w * u_xlat16_26 + 1.0;
          
          u_xlat16_26 = u_xlat16_26 * unity_SpecCube0_HDR.x;
          
          u_xlat16_6.xyz = u_xlat16_2.xyz * float3(u_xlat16_26);
          
          u_xlat16_6.xyz = float3(u_xlat16_1) * u_xlat16_6.xyz;
          
          out_f.color.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
          
          u_xlat16_5.xyz = u_xlat0_d.xyz + (-unity_SpecCube0_BoxMax.xyz);
          
          u_xlat16_6.xyz = (-u_xlat0_d.xyz) + unity_SpecCube0_BoxMin.xyz;
          
          u_xlat16_5.xyz = max(u_xlat16_5.xyz, u_xlat16_6.xyz);
          
          u_xlat16_5.xyz = max(u_xlat16_5.xyz, float3(0.0, 0.0, 0.0));
          
          u_xlat16_5.x = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
          
          u_xlat16_5.x = sqrt(u_xlat16_5.x);
          
          u_xlat0_d.x = u_xlat16_5.x / unity_SpecCube1_ProbePosition.w;
          
          u_xlat0_d.x = (-u_xlat0_d.x) + 1.0;
          
          u_xlat0_d.x = clamp(u_xlat0_d.x, 0.0, 1.0);
          
          out_f.color.w = u_xlat0_d.x;
          
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
      Blend Zero Zero
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
      
      uniform sampler2D _CameraReflectionsTexture;
      
      
      
      struct appdata_t
      {
          
          float4 vertex : POSITION0;
      
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
          
          u_xlat0 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
          
          u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
          
          u_xlat1.w = u_xlat1.x * 0.5;
          
          u_xlat1.xz = u_xlat0.xw * float2(0.5, 0.5);
          
          out_v.vertex = u_xlat0;
          
          out_v.texcoord.xy = u_xlat1.zz + u_xlat1.xw;
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float3 u_xlat16_0;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat16_0.xyz = texture(_CameraReflectionsTexture, in_f.texcoord.xy).xyz;
          
          out_f.color.xyz = exp2((-u_xlat16_0.xyz));
          
          out_f.color.w = 0.0;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
