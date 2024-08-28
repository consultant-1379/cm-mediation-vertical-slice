/*------------------------------------------------------------------------------
 *******************************************************************************
 * COPYRIGHT Ericsson 2018
 *
 * The copyright to the computer program(s) herein is the property of
 * Ericsson Inc. The programs may be used and/or copied only with written
 * permission from Ericsson Inc. or in accordance with the terms and
 * conditions stipulated in the agreement/contract under which the
 * program(s) have been supplied.
 *******************************************************************************
 *----------------------------------------------------------------------------*/
package com.ericsson.oss.mediation.cm.stub;

import java.util.List;

import javax.ejb.Stateless;

import com.ericsson.oss.itpf.security.identitymgmtservices.*;

@Stateless
public class StubbedIdentitymgmtServices implements IdentityManagementService {

    @Override
    public M2MUser createM2MUser(final String userName, final String groupName, final String homeDir, final int validDays)
            throws IdentityManagementServiceException {
        return null;
    }

    @Override
    public boolean deleteM2MUser(final String userName) throws IdentityManagementServiceException {
        return false;
    }

    @Override
    public M2MUser getM2MUser(final String userName) throws IdentityManagementServiceException {
        return null;
    }

    @Override
    public boolean isExistingM2MUser(final String userName) throws IdentityManagementServiceException {
        return true;
    }

    @Override
    public char[] getM2MPassword(final String userName) throws IdentityManagementServiceException {
        final char[] password = { 's', 'h', 'r', 'o', 'o', 't' };
        return password;
    }

    @Override
    public char[] updateM2MPassword(final String userName) throws IdentityManagementServiceException {
        return null;
    }

    @Override
    public List<String> getAllTargetGroups() throws IdentityManagementServiceException {
        return null;
    }

    @Override
    public String getDefaultTargetGroup() throws IdentityManagementServiceException {
        return null;
    }

    @Override
    public List<String> validateTargetGroups(final List<String> targetGroups) throws IdentityManagementServiceException {
        return null;
    }

    @Override
    public ProxyAgentAccountData createProxyAgentAccount() throws IdentityManagementServiceException {
        return null;
    }

    @Override
    public boolean deleteProxyAgentAccount(final String userDN) throws IdentityManagementServiceException {
        return false;
    }

}