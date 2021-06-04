using UnityEngine;

public class zombieHealth : MonoBehaviour
{
    public float mainhealth = 100f;
	public GameObject collider;
	public int isalive = 1;
	
	public gameController thisScore;
	
    public void damageTake(float amt){
		{
			if (isalive == 1)
			{
				mainhealth -= amt;
				if(mainhealth <= 0f){
					dead();
					isalive = 0;
				}
			}
		}
    }

    void dead()
	{
		thisScore.addToScore();
		
    }
}
