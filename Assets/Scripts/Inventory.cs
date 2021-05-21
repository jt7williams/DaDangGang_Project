// Tandy Dang
// UCR CS179N Spring 2021

using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[System.Serializable]
public class Inventory : MonoBehaviour {
    //public List<IStructure> structureList;// = new List<IStructure>();
    public List<IStructure> structures;

    void Start() {
        //structureList = new List<IStructure>();
        
    }

    void Add(IStructure structure) {
        this.structures.Add(structure);
    }

    void Remove(IStructure structure) {
        this.structures.Remove(structure);
    }
}
