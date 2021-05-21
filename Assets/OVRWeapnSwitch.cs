using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class OVRWeapnSwitch : MonoBehaviour
{
    // Start is called before the first frame update
    public GameObject _m4;
    public GameObject _Skorpion;
    public GameObject _ak;
    public OVRInput.Button WeaponSwitchButton;
    public GameObject LHandProp;
    uint iterate = 0;
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        if (OVRInput.GetDown(WeaponSwitchButton))
        {
            iterate++;
            switch (iterate)
            {
                case 0:
                    LHandProp.GetComponent<Collider>().enabled = false;
                    _m4.SetActive(false);
                    _Skorpion.SetActive(false);
                    _ak.SetActive(false);
                    break;
                case 1:
                    LHandProp.GetComponent<Collider>().enabled = true;
                    LHandProp.transform.localPosition = new Vector3(0.025f, -0.02f, 0.418f);
                    LHandProp.transform.localRotation = Quaternion.Euler(new Vector3(-18.943f, -27.731f, -86.269f));
                    _m4.SetActive(true);
                    _Skorpion.SetActive(false);
                    _ak.SetActive(false);
                    break;
                case 2:
                    LHandProp.GetComponent<Collider>().enabled = false;
                    _m4.SetActive(false);
                    _Skorpion.SetActive(true);
                    _ak.SetActive(false);
                    break;
                case 3:
                    LHandProp.GetComponent<Collider>().enabled = true;
                    LHandProp.transform.localPosition = new Vector3(0.025f, -0.02f, 0.418f);
                    LHandProp.transform.localRotation = Quaternion.Euler(new Vector3(-18.943f, -27.731f, -86.269f));
                    _m4.SetActive(false);
                    _Skorpion.SetActive(false);
                    _ak.SetActive(true);
                    break;

                default:
                    iterate = 0;
                    _m4.SetActive(false);
                    _Skorpion.SetActive(false);
                    _ak.SetActive(false);
                    LHandProp.GetComponent<Collider>().enabled= false;
                    break;
            }
        }
        
    }
}
