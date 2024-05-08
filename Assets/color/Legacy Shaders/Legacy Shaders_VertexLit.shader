Shader "Legacy Shaders/VertexLit"
{
  Properties
  {
    _Color ("Main Color", Color) = (1,1,1,1)
    _SpecColor ("Spec Color", Color) = (1,1,1,1)
    _Emission ("Emissive Color", Color) = (0,0,0,0)
    [PowerSlider(5.0)] _Shininess ("Shininess", Range(0.01, 1)) = 0.7
    _MainTex ("Base (RGB)", 2D) = "white" {}
  }
  SubShader
  {
    Tags
    { 
      "RenderType" = "Opaque"
    }
    LOD 100
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "LIGHTMODE" = "Vertex"
        "RenderType" = "Opaque"
      }
      LOD 100
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
      
      
      uniform float4 unity_LightColor[8];
      
      uniform float4 unity_LightPosition[8];
      
      uniform float4 unity_ObjectToWorld[4];
      
      uniform float4 unity_WorldToObject[4];
      
      uniform float4 glstate_lightmodel_ambient;
      
      uniform float4 unity_MatrixV[4];
      
      uniform float4 unity_MatrixInvV[4];
      
      uniform float4 unity_MatrixVP[4];
      
      uniform float4 _Color;
      
      uniform float4 _SpecColor;
      
      uniform float4 _Emission;
      
      uniform float _Shininess;
      
      uniform int4 unity_VertexLightParams;
      
      uniform float4 _MainTex_ST;
      
      uniform sampler2D _MainTex;
      
      
      
      struct appdata_t
      {
          
          float3 vertex : POSITION0;
          
          float3 normal : NORMAL0;
          
          float3 texcoord : TEXCOORD0;
      
      };
      
      
      struct OUT_Data_Vert
      {
          
          float4 color : COLOR0;
          
          float3 color1 : COLOR1;
          
          float2 texcoord : TEXCOORD0;
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float4 color : COLOR0;
          
          float3 color1 : COLOR1;
          
          float2 texcoord : TEXCOORD0;
      
      };
      
      
      struct OUT_Data_Frag
      {
          
          float4 color : SV_Target0;
      
      };
      
      
      float4 u_xlat0;
      
      float4 u_xlat1;
      
      float3 u_xlat2;
      
      int u_xlatb2;
      
      float3 u_xlat3;
      
      float3 u_xlat4;
      
      float3 u_xlat5;
      
      float3 u_xlat6;
      
      float3 u_xlat16_7;
      
      float3 u_xlat16_8;
      
      float3 u_xlat16_9;
      
      float3 u_xlat16_10;
      
      float3 u_xlat16_11;
      
      float u_xlat36;
      
      int u_xlati37;
      
      float u_xlat16_43;
      
      float u_xlat16_44;
      
      OUT_Data_Vert vert(appdata_t in_v)
      {
          
          u_xlat0.xyz = unity_ObjectToWorld[0].yyy * unity_MatrixV[1].xyz;
          
          u_xlat0.xyz = unity_MatrixV[0].xyz * unity_ObjectToWorld[0].xxx + u_xlat0.xyz;
          
          u_xlat0.xyz = unity_MatrixV[2].xyz * unity_ObjectToWorld[0].zzz + u_xlat0.xyz;
          
          u_xlat0.xyz = unity_MatrixV[3].xyz * unity_ObjectToWorld[0].www + u_xlat0.xyz;
          
          u_xlat1.xyz = unity_ObjectToWorld[1].yyy * unity_MatrixV[1].xyz;
          
          u_xlat1.xyz = unity_MatrixV[0].xyz * unity_ObjectToWorld[1].xxx + u_xlat1.xyz;
          
          u_xlat1.xyz = unity_MatrixV[2].xyz * unity_ObjectToWorld[1].zzz + u_xlat1.xyz;
          
          u_xlat1.xyz = unity_MatrixV[3].xyz * unity_ObjectToWorld[1].www + u_xlat1.xyz;
          
          u_xlat2.xyz = unity_ObjectToWorld[2].yyy * unity_MatrixV[1].xyz;
          
          u_xlat2.xyz = unity_MatrixV[0].xyz * unity_ObjectToWorld[2].xxx + u_xlat2.xyz;
          
          u_xlat2.xyz = unity_MatrixV[2].xyz * unity_ObjectToWorld[2].zzz + u_xlat2.xyz;
          
          u_xlat2.xyz = unity_MatrixV[3].xyz * unity_ObjectToWorld[2].www + u_xlat2.xyz;
          
          u_xlat3.xyz = unity_ObjectToWorld[3].yyy * unity_MatrixV[1].xyz;
          
          u_xlat3.xyz = unity_MatrixV[0].xyz * unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
          
          u_xlat3.xyz = unity_MatrixV[2].xyz * unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
          
          u_xlat3.xyz = unity_MatrixV[3].xyz * unity_ObjectToWorld[3].www + u_xlat3.xyz;
          
          u_xlat4.xyz = unity_WorldToObject[1].xyz * unity_MatrixInvV[0].yyy;
          
          u_xlat4.xyz = unity_WorldToObject[0].xyz * unity_MatrixInvV[0].xxx + u_xlat4.xyz;
          
          u_xlat4.xyz = unity_WorldToObject[2].xyz * unity_MatrixInvV[0].zzz + u_xlat4.xyz;
          
          u_xlat4.xyz = unity_WorldToObject[3].xyz * unity_MatrixInvV[0].www + u_xlat4.xyz;
          
          u_xlat5.xyz = unity_WorldToObject[1].xyz * unity_MatrixInvV[1].yyy;
          
          u_xlat5.xyz = unity_WorldToObject[0].xyz * unity_MatrixInvV[1].xxx + u_xlat5.xyz;
          
          u_xlat5.xyz = unity_WorldToObject[2].xyz * unity_MatrixInvV[1].zzz + u_xlat5.xyz;
          
          u_xlat5.xyz = unity_WorldToObject[3].xyz * unity_MatrixInvV[1].www + u_xlat5.xyz;
          
          u_xlat6.xyz = unity_WorldToObject[1].xyz * unity_MatrixInvV[2].yyy;
          
          u_xlat6.xyz = unity_WorldToObject[0].xyz * unity_MatrixInvV[2].xxx + u_xlat6.xyz;
          
          u_xlat6.xyz = unity_WorldToObject[2].xyz * unity_MatrixInvV[2].zzz + u_xlat6.xyz;
          
          u_xlat6.xyz = unity_WorldToObject[3].xyz * unity_MatrixInvV[2].www + u_xlat6.xyz;
          
          u_xlat1.xyz = u_xlat1.xyz * in_v.vertex.yyy;
          
          u_xlat0.xyz = u_xlat0.xyz * in_v.vertex.xxx + u_xlat1.xyz;
          
          u_xlat0.xyz = u_xlat2.xyz * in_v.vertex.zzz + u_xlat0.xyz;
          
          u_xlat0.xyz = u_xlat3.xyz + u_xlat0.xyz;
          
          u_xlat1.x = dot(u_xlat4.xyz, in_v.normal.xyz);
          
          u_xlat1.y = dot(u_xlat5.xyz, in_v.normal.xyz);
          
          u_xlat1.z = dot(u_xlat6.xyz, in_v.normal.xyz);
          
          u_xlat36 = dot(u_xlat1.xyz, u_xlat1.xyz);
          
          u_xlat36 = inversesqrt(u_xlat36);
          
          u_xlat1.xyz = float3(u_xlat36) * u_xlat1.xyz;
          
          u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
          
          u_xlat36 = inversesqrt(u_xlat36);
          
          u_xlat16_7.xyz = _Color.xyz * glstate_lightmodel_ambient.xyz + _Emission.xyz;
          
          u_xlat16_43 = _Shininess * 128.0;
          
          u_xlat16_8.xyz = u_xlat16_7.xyz;
          
          u_xlat16_9.x = float(0.0);
          
          u_xlat16_9.y = float(0.0);
          
          u_xlat16_9.z = float(0.0);
          
          for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<unity_VertexLightParams.x ; u_xlati_loop_1++)
      
          
              {
              
              u_xlat16_44 = dot(u_xlat1.xyz, unity_LightPosition[u_xlati_loop_1].xyz);
              
              u_xlat16_44 = max(u_xlat16_44, 0.0);
              
              u_xlat16_10.xyz = float3(u_xlat16_44) * _Color.xyz;
              
              u_xlat16_10.xyz = u_xlat16_10.xyz * unity_LightColor[u_xlati_loop_1].xyz;
              
              u_xlatb2 = 0.0<u_xlat16_44;
              
              if(u_xlatb2)
      {
                  
                  u_xlat16_11.xyz = (-u_xlat0.xyz) * float3(u_xlat36) + unity_LightPosition[u_xlati_loop_1].xyz;
                  
                  u_xlat16_44 = dot(u_xlat16_11.xyz, u_xlat16_11.xyz);
                  
                  u_xlat16_44 = inversesqrt(u_xlat16_44);
                  
                  u_xlat16_11.xyz = float3(u_xlat16_44) * u_xlat16_11.xyz;
                  
                  u_xlat16_44 = dot(u_xlat1.xyz, u_xlat16_11.xyz);
                  
                  u_xlat16_44 = max(u_xlat16_44, 0.0);
                  
                  u_xlat16_44 = log2(u_xlat16_44);
                  
                  u_xlat16_44 = u_xlat16_43 * u_xlat16_44;
                  
                  u_xlat16_44 = exp2(u_xlat16_44);
                  
                  u_xlat16_44 = min(u_xlat16_44, 1.0);
                  
                  u_xlat16_44 = u_xlat16_44 * 0.5;
                  
                  u_xlat16_9.xyz = float3(u_xlat16_44) * unity_LightColor[u_xlati_loop_1].xyz + u_xlat16_9.xyz;
      
      }
              
              u_xlat16_10.xyz = u_xlat16_10.xyz * float3(0.5, 0.5, 0.5);
              
              u_xlat16_10.xyz = min(u_xlat16_10.xyz, float3(1.0, 1.0, 1.0));
              
              u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_10.xyz;
      
      }
          
          out_v.color1.xyz = u_xlat16_9.xyz * _SpecColor.xyz;
          
          out_v.color1.xyz = clamp(out_v.color1.xyz, 0.0, 1.0);
          
          out_v.color.xyz = u_xlat16_8.xyz;
          
          out_v.color.xyz = clamp(out_v.color.xyz, 0.0, 1.0);
          
          out_v.color.w = _Color.w;
          
          out_v.color.w = clamp(out_v.color.w, 0.0, 1.0);
          
          out_v.texcoord.xy = in_v.texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
          
          u_xlat0 = in_v.vertex.yyyy * unity_ObjectToWorld[1];
          
          u_xlat0 = unity_ObjectToWorld[0] * in_v.vertex.xxxx + u_xlat0;
          
          u_xlat0 = unity_ObjectToWorld[2] * in_v.vertex.zzzz + u_xlat0;
          
          u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
          
          u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
          
          u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
          
          u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
          
          out_v.vertex = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float3 u_xlat16_0;
      
      float3 u_xlat16_1;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat16_0.xyz = texture(_MainTex, in_f.texcoord.xy).xyz;
          
          u_xlat16_1.xyz = u_xlat16_0.xyz * in_f.color.xyz;
          
          out_f.color.xyz = u_xlat16_1.xyz * float3(2.0, 2.0, 2.0) + in_f.color1.xyz;
          
          out_f.color.w = 1.0;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 2, name: 
    {
      Tags
      { 
        "LIGHTMODE" = "VertexLM"
        "RenderType" = "Opaque"
      }
      LOD 100
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      
      
      uniform float4 unity_ObjectToWorld[4];
      
      uniform float4 unity_MatrixVP[4];
      
      uniform float4 unity_LightmapST;
      
      uniform float4 unity_Lightmap_ST;
      
      uniform float4 _MainTex_ST;
      
      uniform float4 unity_Lightmap_HDR;
      
      uniform float4 _Color;
      
      uniform sampler2D _MainTex;
      
      uniform sampler2D unity_Lightmap;
      
      
      
      struct appdata_t
      {
          
          float3 vertex : POSITION0;
          
          float3 texcoord1 : TEXCOORD1;
          
          float3 texcoord : TEXCOORD0;
      
      };
      
      
      struct OUT_Data_Vert
      {
          
          float2 texcoord : TEXCOORD0;
          
          float2 texcoord1 : TEXCOORD1;
          
          float2 texcoord2 : TEXCOORD2;
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float2 texcoord : TEXCOORD0;
          
          float2 texcoord2 : TEXCOORD2;
      
      };
      
      
      struct OUT_Data_Frag
      {
          
          float4 color : SV_Target0;
      
      };
      
      
      float4 u_xlat0;
      
      float4 u_xlat1;
      
      OUT_Data_Vert vert(appdata_t in_v)
      {
          
          out_v.texcoord.xy = in_v.texcoord1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
          
          out_v.texcoord1.xy = in_v.texcoord1.xy * unity_Lightmap_ST.xy + unity_Lightmap_ST.zw;
          
          out_v.texcoord2.xy = in_v.texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
          
          u_xlat0 = in_v.vertex.yyyy * unity_ObjectToWorld[1];
          
          u_xlat0 = unity_ObjectToWorld[0] * in_v.vertex.xxxx + u_xlat0;
          
          u_xlat0 = unity_ObjectToWorld[2] * in_v.vertex.zzzz + u_xlat0;
          
          u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
          
          u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
          
          u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
          
          u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
          
          out_v.vertex = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float3 u_xlat16_0;
      
      float3 u_xlat16_1;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat16_0.xyz = texture(unity_Lightmap, in_f.texcoord.xy).xyz;
          
          u_xlat16_1.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
          
          u_xlat16_1.xyz = u_xlat16_1.xyz * _Color.xyz;
          
          u_xlat16_0.xyz = texture(_MainTex, in_f.texcoord2.xy).xyz;
          
          out_f.color.xyz = u_xlat16_1.xyz * u_xlat16_0.xyz;
          
          out_f.color.w = 1.0;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 3, name: ShadowCaster
    {
      Name "ShadowCaster"
      Tags
      { 
        "LIGHTMODE" = "SHADOWCASTER"
        "RenderType" = "Opaque"
        "SHADOWSUPPORT" = "true"
      }
      LOD 100
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      
      
      uniform float4 _WorldSpaceLightPos0;
      
      uniform float4 unity_LightShadowBias;
      
      uniform float4 unity_ObjectToWorld[4];
      
      uniform float4 unity_WorldToObject[4];
      
      uniform float4 unity_MatrixVP[4];
      
      
      
      struct appdata_t
      {
          
          float4 vertex : POSITION0;
          
          float3 normal : NORMAL0;
      
      };
      
      
      struct OUT_Data_Vert
      {
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float4 vertex : Position;
      
      };
      
      
      struct OUT_Data_Frag
      {
          
          float4 color : SV_Target0;
      
      };
      
      
      float4 u_xlat0;
      
      float4 u_xlat1;
      
      float4 u_xlat2;
      
      float u_xlat6;
      
      float u_xlat9;
      
      int u_xlatb9;
      
      OUT_Data_Vert vert(appdata_t in_v)
      {
          
          u_xlat0.x = dot(in_v.normal.xyz, unity_WorldToObject[0].xyz);
          
          u_xlat0.y = dot(in_v.normal.xyz, unity_WorldToObject[1].xyz);
          
          u_xlat0.z = dot(in_v.normal.xyz, unity_WorldToObject[2].xyz);
          
          u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
          
          u_xlat9 = inversesqrt(u_xlat9);
          
          u_xlat0.xyz = float3(u_xlat9) * u_xlat0.xyz;
          
          u_xlat1 = in_v.vertex.yyyy * unity_ObjectToWorld[1];
          
          u_xlat1 = unity_ObjectToWorld[0] * in_v.vertex.xxxx + u_xlat1;
          
          u_xlat1 = unity_ObjectToWorld[2] * in_v.vertex.zzzz + u_xlat1;
          
          u_xlat1 = unity_ObjectToWorld[3] * in_v.vertex.wwww + u_xlat1;
          
          u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
          
          u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
          
          u_xlat9 = inversesqrt(u_xlat9);
          
          u_xlat2.xyz = float3(u_xlat9) * u_xlat2.xyz;
          
          u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
          
          u_xlat9 = (-u_xlat9) * u_xlat9 + 1.0;
          
          u_xlat9 = sqrt(u_xlat9);
          
          u_xlat9 = u_xlat9 * unity_LightShadowBias.z;
          
          u_xlat0.xyz = (-u_xlat0.xyz) * float3(u_xlat9) + u_xlat1.xyz;
          
          u_xlatb9 = unity_LightShadowBias.z!=0.0;
          
          u_xlat0.xyz = (int(u_xlatb9)) ? u_xlat0.xyz : u_xlat1.xyz;
          
          u_xlat2 = u_xlat0.yyyy * unity_MatrixVP[1];
          
          u_xlat2 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
          
          u_xlat0 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
          
          u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
          
          u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
          
          u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
          
          u_xlat6 = u_xlat0.z + u_xlat1.x;
          
          u_xlat1.x = max((-u_xlat0.w), u_xlat6);
          
          out_v.vertex.xyw = u_xlat0.xyw;
          
          u_xlat0.x = (-u_xlat6) + u_xlat1.x;
          
          out_v.vertex.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat6;
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          out_f.color = float4(0.0, 0.0, 0.0, 0.0);
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
