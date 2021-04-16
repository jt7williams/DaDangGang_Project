// Tandy Dang
// UCR CS179N Spring 2021

using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Inventory : MonoBehaviour
{
    public List<Structure> structureList;

    void Start()
    {
        structureList = new List<Structure>();
    }

    void Add(Structure structure) {
        this.structureList.Add(structure);
    }

    void Remove(Structure structure) {
        this.structureList.Remove(structure);
    }
}
