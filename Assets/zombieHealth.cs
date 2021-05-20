using UnityEngine;

public class zombieHealth : MonoBehaviour
{
    public float mainhealth = 100f;
	public GameObject flesh;
	public GameObject dependency;
	public GameObject collider;
	public GameObject zombie;
	public GameObject removable;
	
	public GameObject splat;
	
	int isalive = 1;
    public void damageTake(float amt){
		if (dependency == null) 
		{
			if (isalive == 1)
			{
				mainhealth -= amt;
				if(mainhealth <= 0f){
					dead();
				}
			}
		}
    }

    void dead()
	{

    }
}
