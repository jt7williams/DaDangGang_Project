// Tandy Dang
// UCR CS179N Spring 2021

using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Structure : MonoBehaviour
{
    public int health;
    public enum Type { None, Block }
    public Type type;

    void Start()
    {
        this.type = Type.None;
        //this.tag = "Structure";
    }


    void Update()
    {
        
    }
}
