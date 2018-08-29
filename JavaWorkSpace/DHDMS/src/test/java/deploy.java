import org.activiti.engine.*;
import org.junit.Test;

/**
 * Created by tongc on 2017-9-20.
 */
public class deploy {
    @Test
    public void processTests() {
        ProcessEngine processEngine = ProcessEngineConfiguration.createProcessEngineConfigurationFromResource("dhchain-data.xml").buildProcessEngine();
        RepositoryService repositoryService = processEngine.getRepositoryService();
        RuntimeService runtimeService = processEngine.getRuntimeService();
        repositoryService.createDeployment().name("面试流程").addClasspathResource("diagrams/test/vacationRequest6.xml").deploy();
    }


}
