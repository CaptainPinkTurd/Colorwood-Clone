Shader "Hidden/CubeBlend"
{
  Properties
  {
    [NoScaleOffset] _TexA ("Cubemap", Cube) = "grey" {}
    [NoScaleOffset] _TexB ("Cubemap", Cube) = "grey" {}
    _value ("Value", Range(0, 1)) = 0.5
  }
  SubShader
  {
    Tags
    { 
      "QUEUE" = "Background"
      "RenderType" = "Background"
    }
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "QUEUE" = "Background"
        "RenderType" = "Background"
      }
      ZTest Always
      ZWrite Off
      Fog
      { 
        Mode  Off
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
      
      uniform float4 _TexA_HDR;
      
      uniform float4 _TexB_HDR;
      
      uniform float _Level;
      
      uniform float _value;
      
      uniform samplerCUBE _TexA;
      
      uniform samplerCUBE _TexB;
      
      
      
      struct appdata_t
      {
          
          float4 vertex : POSITION0;
          
          float3 texcoord : TEXCOORD0;
      
      };
      
      
      struct OUT_Data_Vert
      {
          
          float3 texcoord : TEXCOORD0;
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float3 texcoord : TEXCOORD0;
      
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
          
          out_v.texcoord.xyz = in_v.texcoord.xyz;
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float3 u_xlat0_d;
      
      float4 u_xlat16_0;
      
      float3 u_xlat16_1;
      
      float u_xlat16_7;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat16_0 = textureLod(_TexA, in_f.texcoord.xyz, _Level);
          
          u_xlat16_1.x = u_xlat16_0.w + -1.0;
          
          u_xlat16_1.x = _TexA_HDR.w * u_xlat16_1.x + 1.0;
          
          u_xlat16_1.x = u_xlat16_1.x * _TexA_HDR.x;
          
          u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx;
          
          u_xlat16_0 = textureLod(_TexB, in_f.texcoord.xyz, _Level);
          
          u_xlat16_7 = u_xlat16_0.w + -1.0;
          
          u_xlat16_7 = _TexB_HDR.w * u_xlat16_7 + 1.0;
          
          u_xlat16_7 = u_xlat16_7 * _TexB_HDR.x;
          
          u_xlat0_d.xyz = float3(u_xlat16_7) * u_xlat16_0.xyz + (-u_xlat16_1.xyz);
          
          u_xlat0_d.xyz = float3(float3(_value, _value, _value)) * u_xlat0_d.xyz + u_xlat16_1.xyz;
          
          out_f.color.xyz = u_xlat0_d.xyz;
          
          out_f.color.w = 1.0;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
  }
  SubShader
  {
    Tags
    { 
      "QUEUE" = "Background"
      "RenderType" = "Background"
    }
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "QUEUE" = "Background"
        "RenderType" = "Background"
      }
      ZTest Always
      ZWrite Off
      Fog
      { 
        Mode  Off
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
      
      uniform float4 _TexA_HDR;
      
      uniform float4 _TexB_HDR;
      
      uniform float _Level;
      
      uniform float _value;
      
      uniform samplerCUBE _TexA;
      
      uniform samplerCUBE _TexB;
      
      
      
      struct appdata_t
      {
          
          float4 vertex : POSITION0;
          
          float3 texcoord : TEXCOORD0;
      
      };
      
      
      struct OUT_Data_Vert
      {
          
          float3 texcoord : TEXCOORD0;
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float3 texcoord : TEXCOORD0;
      
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
          
          out_v.texcoord.xyz = in_v.texcoord.xyz;
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float3 u_xlat0_d;
      
      float4 u_xlat16_0;
      
      float3 u_xlat16_1;
      
      float u_xlat16_7;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat16_0 = textureLod(_TexA, in_f.texcoord.xyz, _Level);
          
          u_xlat16_1.x = u_xlat16_0.w + -1.0;
          
          u_xlat16_1.x = _TexA_HDR.w * u_xlat16_1.x + 1.0;
          
          u_xlat16_1.x = u_xlat16_1.x * _TexA_HDR.x;
          
          u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx;
          
          u_xlat16_0 = textureLod(_TexB, in_f.texcoord.xyz, _Level);
          
          u_xlat16_7 = u_xlat16_0.w + -1.0;
          
          u_xlat16_7 = _TexB_HDR.w * u_xlat16_7 + 1.0;
          
          u_xlat16_7 = u_xlat16_7 * _TexB_HDR.x;
          
          u_xlat0_d.xyz = float3(u_xlat16_7) * u_xlat16_0.xyz + (-u_xlat16_1.xyz);
          
          u_xlat0_d.xyz = float3(float3(_value, _value, _value)) * u_xlat0_d.xyz + u_xlat16_1.xyz;
          
          out_f.color.xyz = u_xlat0_d.xyz;
          
          out_f.color.w = 1.0;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
