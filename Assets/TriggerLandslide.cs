using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TriggerLandslide : MonoBehaviour
{
    public GameObject[] rocks;
    // Start is called before the first frame update
    void Start()
    {
        foreach (GameObject rock in rocks)
        {
            rock.GetComponent<Rigidbody>().useGravity = true;
            rock.GetComponent<Rigidbody>().isKinematic = true;
        }
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    private void OnTriggerEnter(Collider other)
    {
        foreach(GameObject rock in rocks)
        {
            rock.GetComponent<Rigidbody>().useGravity = true;
            rock.GetComponent<Rigidbody>().isKinematic = false;
        }
    }
}
