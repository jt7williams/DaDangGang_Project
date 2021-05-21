using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Block : IStructure {
    // Start is called before the first frame update
    void Start() {
        //this.type = Structure.Type.Block;
    }

    void Update() {
        
    }

    public override void Place(Vector3 position) {
        //Debug.Log("Place()");
        Instantiate(this.gameObject, position, Quaternion.identity);
    }

    public override void Remove(IStructure target) {
        Destroy(target.gameObject);
    }
}
