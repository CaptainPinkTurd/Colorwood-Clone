Shader "Hidden/CubeBlur"
{
  Properties
  {
    _MainTex ("Main", Cube) = "" {}
    _Texel ("Texel", float) = 0.0078125
    _Level ("Level", float) = 0
    _Scale ("Scale", float) = 1
  }
  SubShader
  {
    Tags
    { 
      "RenderType" = "Opaque"
    }
    LOD 200
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "RenderType" = "Opaque"
      }
      LOD 200
      ZTest Always
      ZWrite Off
      Cull Off
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
      
      uniform float _Level;
      
      uniform float _Texel;
      
      uniform float _Scale;
      
      uniform samplerCUBE _MainTex;
      
      
      
      struct appdata_t
      {
          
          float4 vertex : POSITION0;
          
          float4 texcoord : TEXCOORD0;
      
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
          
          out_v.texcoord = in_v.texcoord;
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float4 ImmCB_0[4];
      
      int u_xlati0;
      
      bool3 u_xlatb0;
      
      float3 u_xlat16_1;
      
      float3 u_xlat16_2;
      
      float3 u_xlat16_3;
      
      float3 u_xlat16_4;
      
      float3 u_xlat16_5;
      
      float3 u_xlat16_6;
      
      int u_xlati7;
      
      float3 u_xlat16_8;
      
      float3 u_xlat16_9;
      
      float3 u_xlat16_10;
      
      float u_xlat11;
      
      int u_xlatb11;
      
      float3 u_xlat18;
      
      float3 u_xlat16_18;
      
      int u_xlatb18;
      
      int u_xlati22;
      
      float u_xlat33;
      
      int u_xlati33;
      
      int u_xlatb33;
      
      float u_xlat16_34;
      
      float u_xlat16_35;
      
      float u_xlat16_36;
      
      float u_xlat16_37;
      
      float u_xlat16_38;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          ImmCB_0[0] = float4(1.0,0.0,0.0,0.0);
          
          ImmCB_0[1] = float4(0.0,1.0,0.0,0.0);
          
          ImmCB_0[2] = float4(0.0,0.0,1.0,0.0);
          
          ImmCB_0[3] = float4(0.0,0.0,0.0,1.0);
          
          u_xlatb0.xyz = equal(abs(in_f.texcoord.xyzx), float4(1.0, 1.0, 1.0, 0.0)).xyz;
          
          u_xlat16_1.x = (u_xlatb0.x) ? in_f.texcoord.x : float(0.0);
          
          u_xlat16_1.y = (u_xlatb0.y) ? in_f.texcoord.y : float(0.0);
          
          u_xlat16_1.z = (u_xlatb0.z) ? in_f.texcoord.z : float(0.0);
          
          u_xlat16_2.xyz = u_xlat16_1.zxy * float3(float3(_Texel, _Texel, _Texel));
          
          u_xlat16_3.xyz = -abs(u_xlat16_1.xyz) + float3(1.0, 1.0, 1.0);
          
          u_xlat16_3.xyz = u_xlat16_3.xyz * in_f.texcoord.xyz;
          
          u_xlat16_34 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
          
          u_xlat16_34 = u_xlat16_34 + 1.0;
          
          u_xlat16_34 = sqrt(u_xlat16_34);
          
          u_xlat16_34 = float(1.0) / u_xlat16_34;
          
          u_xlat16_35 = u_xlat16_34 * u_xlat16_34;
          
          u_xlat16_3.x = u_xlat16_34 * u_xlat16_35;
          
          u_xlat16_3.yz = u_xlat16_3.xx * float2(float2(_Scale, _Scale));
          
          u_xlat16_4.x = _Scale;
          
          u_xlat16_4.y = float(3.0);
          
          u_xlat16_4.z = float(5.0);
          
          u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
          
          u_xlat16_3.xyz = u_xlat16_3.xyz * (-u_xlat16_3.xyz);
          
          u_xlat16_3.xyz = u_xlat16_3.xyz * float3(1.44269502, 1.44269502, 1.44269502);
          
          u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
          
          u_xlat16_4.x = float(0.0);
          
          u_xlat16_4.y = float(0.0);
          
          u_xlat16_4.z = float(0.0);
          
          u_xlat16_34 = 0.0;
          
          for(int u_xlati_loop_1 = 2 ; u_xlati_loop_1>=0 ; u_xlati_loop_1 = u_xlati_loop_1 + int(0xFFFFFFFFu))
      
          
              {
              
              u_xlat16_35 = float(u_xlati_loop_1);
              
              u_xlat11 = u_xlat16_35 + 0.5;
              
              u_xlat16_35 = dot(u_xlat16_3.xyz, ImmCB_0[u_xlati_loop_1].xyz);
              
              u_xlat16_5.xyz = u_xlat16_4.xyz;
              
              u_xlat16_36 = u_xlat16_34;
              
              for(int u_xlati_loop_2 = 0 ; u_xlati_loop_2<2 ; u_xlati_loop_2++)
      
              
                  {
                  
                  u_xlati33 = int(u_xlati_loop_2 << (1 & int(0x1F)));
                  
                  u_xlati33 = u_xlati33 + int(0xFFFFFFFFu);
                  
                  u_xlat16_37 = float(u_xlati33);
                  
                  u_xlat33 = u_xlat11 * u_xlat16_37;
                  
                  u_xlat16_6.xyz = u_xlat16_5.xyz;
                  
                  u_xlat16_37 = u_xlat16_36;
                  
                  for(int u_xlati_loop_3 = 2 ; u_xlati_loop_3>=0 ; u_xlati_loop_3 = u_xlati_loop_3 + int(0xFFFFFFFFu))
      
                  
                      {
                      
                      u_xlat16_38 = float(u_xlati_loop_3);
                      
                      u_xlat18.x = u_xlat16_38 + 0.5;
                      
                      u_xlat16_8.xyz = (-u_xlat18.xxx) * u_xlat16_2.xyz + in_f.texcoord.xyz;
                      
                      u_xlat16_8.xyz = float3(u_xlat33) * u_xlat16_2.zxy + u_xlat16_8.xyz;
                      
                      u_xlat16_9.xyz = max(u_xlat16_8.xyz, float3(-1.0, -1.0, -1.0));
                      
                      u_xlat16_9.xyz = min(u_xlat16_9.xyz, float3(1.0, 1.0, 1.0));
                      
                      u_xlat16_8.xyz = u_xlat16_8.xyz + (-u_xlat16_9.xyz);
                      
                      u_xlat16_38 = max(abs(u_xlat16_8.y), abs(u_xlat16_8.x));
                      
                      u_xlat16_38 = max(abs(u_xlat16_8.z), u_xlat16_38);
                      
                      u_xlat16_8.xyz = (-float3(u_xlat16_38)) * u_xlat16_1.xyz + u_xlat16_9.xyz;
                      
                      u_xlat16_10.xyz = textureLod(_MainTex, u_xlat16_8.xyz, _Level).xyz;
                      
                      u_xlat16_8.xyz = u_xlat18.xxx * u_xlat16_2.xyz + in_f.texcoord.xyz;
                      
                      u_xlat16_8.xyz = float3(u_xlat33) * u_xlat16_2.zxy + u_xlat16_8.xyz;
                      
                      u_xlat16_9.xyz = max(u_xlat16_8.xyz, float3(-1.0, -1.0, -1.0));
                      
                      u_xlat16_9.xyz = min(u_xlat16_9.xyz, float3(1.0, 1.0, 1.0));
                      
                      u_xlat16_8.xyz = u_xlat16_8.xyz + (-u_xlat16_9.xyz);
                      
                      u_xlat16_38 = max(abs(u_xlat16_8.y), abs(u_xlat16_8.x));
                      
                      u_xlat16_38 = max(abs(u_xlat16_8.z), u_xlat16_38);
                      
                      u_xlat16_8.xyz = (-float3(u_xlat16_38)) * u_xlat16_1.xyz + u_xlat16_9.xyz;
                      
                      u_xlat16_18.xyz = textureLod(_MainTex, u_xlat16_8.xyz, _Level).xyz;
                      
                      u_xlat18.xyz = u_xlat16_18.xyz + u_xlat16_10.xyz;
                      
                      u_xlat16_38 = dot(u_xlat16_3.xyz, ImmCB_0[u_xlati_loop_3].xyz);
                      
                      u_xlat16_38 = u_xlat16_35 * u_xlat16_38;
                      
                      u_xlat16_6.xyz = u_xlat18.xyz * float3(u_xlat16_38) + u_xlat16_6.xyz;
                      
                      u_xlat16_37 = u_xlat16_38 * 2.0 + u_xlat16_37;
      
      }
                  
                  u_xlat16_5.xyz = u_xlat16_6.xyz;
                  
                  u_xlat16_36 = u_xlat16_37;
      
      }
              
              u_xlat16_4.xyz = u_xlat16_5.xyz;
              
              u_xlat16_34 = u_xlat16_36;
      
      }
          
          out_f.color.xyz = u_xlat16_4.xyz / float3(u_xlat16_34);
          
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
      "RenderType" = "Opaque"
    }
    LOD 200
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "RenderType" = "Opaque"
      }
      LOD 200
      ZTest Always
      ZWrite Off
      Cull Off
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
      
      uniform float _Level;
      
      uniform samplerCUBE _MainTex;
      
      
      
      struct appdata_t
      {
          
          float4 vertex : POSITION0;
          
          float4 texcoord : TEXCOORD0;
      
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
          
          out_v.texcoord = in_v.texcoord;
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float4 u_xlat16_0;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat16_0 = textureLod(_MainTex, in_f.texcoord.xyz, _Level);
          
          out_f.color = u_xlat16_0;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
