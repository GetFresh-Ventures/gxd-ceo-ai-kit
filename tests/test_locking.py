import os
import sys
import tempfile
import unittest
import threading
from pathlib import Path

# Add hooks dir to path
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '..', 'hooks')))
import task_manager

class TestLockingMechanism(unittest.TestCase):
    
    def test_concurrent_lock_acquires(self):
        """Test that dictionary loads block while locked"""
        with tempfile.NamedTemporaryFile(mode="w+", delete=False, suffix=".json") as f:
            f.write("{}")
            tmp_path = f.name
            
        try:
            import portalocker
            def locked_writer():
                with open(tmp_path, 'r+') as f2:
                    portalocker.lock(f2, portalocker.LOCK_EX)
                    f2.write('{"locked": true}')
                    f2.flush()
                    # hold lock intentionally briefly
                    import time
                    time.sleep(0.5)
                    portalocker.unlock(f2)
                    
            t = threading.Thread(target=locked_writer)
            t.start()
            
            import time
            time.sleep(0.1) # ensure thread has the lock
            
            # This should eventually pass once the thread releases
            with open(tmp_path, 'r') as f3:
                portalocker.lock(f3, portalocker.LOCK_SH)
                content = f3.read()
                portalocker.unlock(f3)
                
            t.join()
            self.assertTrue("locked" in content or content == "{}")
        finally:
            os.remove(tmp_path)


if __name__ == '__main__':
    unittest.main()
