// Tandy Dang
// UCR CS179N Spring 2021

using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Inventory : MonoBehaviour
{
    public List<IStructure> structureList;

    void Start()
    {
        structureList = new List<IStructure>();
    }

    void Add(IStructure structure) {
        this.structureList.Add(structure);
    }

    void Remove(IStructure structure) {
        this.structureList.Remove(structure);
    }
}
